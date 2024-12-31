// Services/DatabaseService.swift

import Foundation
import Supabase
import Combine

class DatabaseService: ObservableObject {
    @Published var games: [Game] = []
    @Published var errorMessage: String?
    @Published var gamesLoading: Bool = false
    private let supabaseClient: SupabaseClient
    
    init() {
        guard let url = URL(string: Config.supabaseURL) else {
            fatalError("Invalid Supabase URL")
        }
        let key = Config.supabaseAnonKey
        supabaseClient = SupabaseClient(supabaseURL: url, supabaseKey: key)
    }
    
    func fetchGames() async {
        Task { @MainActor in
            gamesLoading = true
        }
        
        defer {
            Task { @MainActor in
                gamesLoading = false
            }
        }
        
        do {
            let games: [Game] = try await supabaseClient
                .from("games")
                .select()
                .execute()
                .value
            
            Task { @MainActor in
                self.games = games
            }
        } catch {
            Task { @MainActor in
                self.errorMessage = error.localizedDescription
            }
        }
    }

}
