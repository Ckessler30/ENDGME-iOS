// Services/AuthService.swift

import Foundation
import Combine
import Supabase

class AuthService: ObservableObject {
    @Published var isAuthenticated: Bool = false
    @Published var user: User?
    @Published var errorMessage: String?
    @Published var loginError: String?

    
    private let supabaseClient: SupabaseClient
    private var authListener: AuthStateChangeListenerRegistration?
    
    init() async {
           guard let url = URL(string: Config.supabaseURL) else {
               fatalError("Invalid Supabase URL")
           }
           
           let key = Config.supabaseAnonKey
           self.supabaseClient = SupabaseClient(supabaseURL: url, supabaseKey: key)
           
        authListener = await supabaseClient.auth.onAuthStateChange { [weak self] event, session in
            guard let self = self else { return }
            Task { @MainActor in
                switch event {
                case .initialSession:
                    if let session = session {
                        self.isAuthenticated = true
                        self.user = session.user
                    } else {
                        self.isAuthenticated = false
                        self.user = nil
                    }
                case .signedIn:
                    self.isAuthenticated = true
                    self.user = session?.user
                case .signedOut, .userUpdated, .passwordRecovery:
                    self.isAuthenticated = false
                    self.user = nil
                case .tokenRefreshed:
                    // Optionally handle token refreshed
                    break
                default:
                    self.isAuthenticated = false
                    self.user = nil
                }
            }
        }
           
           await updateInitialAuthState()
       }
    
    
    init(mockAuthenticated: Bool = false, mockUser: User? = nil) {
        guard let url = URL(string: Config.supabaseURL), !Config.supabaseAnonKey.isEmpty else {
            fatalError("Invalid Supabase configuration for mock initialization")
        }
        self.supabaseClient = SupabaseClient(supabaseURL: url, supabaseKey: Config.supabaseAnonKey)
        self.isAuthenticated = mockAuthenticated
        self.user = mockUser
    }
       
    private func updateInitialAuthState() async {
        do {
            let session = try await supabaseClient.auth.session
            Task { @MainActor in
                self.isAuthenticated = true
                self.user = session.user
            }
        } catch {
            Task { @MainActor in
                self.isAuthenticated = false
                self.user = nil
            }
            print("Failed to get session: \(error)")
        }
    }



    func signUp(email: String, password: String) async throws -> User {
        do {
            let data = try await supabaseClient.auth.signUp(email: email, password: password)
            return data.user
        } catch {
            self.errorMessage = error.localizedDescription
            throw error
        }
    }


    
    
    func login(email: String, password: String ) async throws {
        do {
            try await supabaseClient.auth.signIn(email: email, password: password)
            Task { @MainActor in
                self.isAuthenticated = true
                self.errorMessage = nil
            }
        } catch {
            Task { @MainActor in
                self.loginError = error.localizedDescription
            }
            throw AuthError.noUserData
        }
    }
    
    
    func logout() async throws {
        try await supabaseClient.auth.signOut()
    }
    

    enum AuthError: Error {
        case noUserData
    }
    
    deinit {
        // Remove the auth state change listener when the instance is deallocated
        authListener?.remove()
    }
}
