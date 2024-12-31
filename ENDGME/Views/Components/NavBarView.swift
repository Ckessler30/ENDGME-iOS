// Views/Components/NavBarView.swift

import SwiftUI

struct NavBarView: View {
    @EnvironmentObject var authService: AuthService
    @EnvironmentObject var navigationManager: NavigationPathManager


    var body: some View {
            HStack {
                if authService.isAuthenticated {
                    UserIconView()
                } else {
                    HStack {
                        Button{
                            navigationManager.path.append(NavigationDestination.login)
                        }label: {
                            Text("Login")
                                .font(.title)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .background(.accent)
                                .cornerRadius(10)
                        }
                        
                        Spacer()
                        
                        Button{
                            navigationManager.path.append(NavigationDestination.signup)
                        } label: {
                            Text("Sign Up")
                                .font(.title)
                                .fontWeight(.semibold)
                                .foregroundColor(.accent)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .background(.white)
                                .cornerRadius(10)
                        }
                    }
                            
                    }
                }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: 70)
            }

}

struct NavBarView_Previews: PreviewProvider {
    @StateObject static var authService = AuthService()
    @StateObject static var navigationManager = NavigationPathManager()

    static var previews: some View {
        NavBarView()
            .environmentObject(authService)
            .environmentObject(navigationManager)
    }
}
