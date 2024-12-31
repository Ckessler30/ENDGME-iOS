import SwiftUI

enum NavigationDestination: Hashable {
    case login
    case signup
    case gameDetail(gameId: UUID)
}

struct MainView: View {
    @EnvironmentObject var navigationManager: NavigationPathManager
    @EnvironmentObject var authService: AuthService
    @EnvironmentObject var databaseService: DatabaseService
    
    @State private var offsetX: CGFloat = UIScreen.main.bounds.width
    
    var body: some View {
        NavigationStack(path: $navigationManager.path) {
            ZStack {
                GradientBackgroundView()
                
                VStack {
                    Marquee()
                    
                    
                    GameGridView()
                    NavBarView()
                        .padding(.horizontal, 20)

                }
            }
            .navigationBarHidden(true)
            .navigationDestination(for: NavigationDestination.self) { destination in
                switch destination {
                case .login:
                    LoginView()
                case .signup:
                    SignupView()
                default:
                    EmptyView()
                }
                
            }
        }
    }
}



struct MainView_Previews: PreviewProvider {
    @StateObject static var navigationManager = NavigationPathManager()
    @StateObject static var authService = AuthService()
    @StateObject static var databaseService = DatabaseService()
    
    static var previews: some View {
        MainView()
            .environmentObject(navigationManager)
            .environmentObject(authService)
            .environmentObject(databaseService)
    }
}

struct Marquee: View {
    @State private var offsetX: CGFloat = UIScreen.main.bounds.width
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                HStack(spacing: 0) {
                    Text("END")
                        .font(.custom("impact", size: 48))
                        .foregroundColor(.white)
                        .opacity(0.5)
                    
                    Text("GME")
                        .font(.custom("impact", size: 48))
                        .foregroundColor(.red)
                        .opacity(0.5)
                }
                .offset(x: offsetX)
                .onAppear {
                    let totalWidth = geometry.size.width * 2
                    withAnimation(
                        Animation.linear(duration: 10)
                            .repeatForever(autoreverses: false)
                    ) {
                        offsetX = -totalWidth
                    }
                }
            }
        }
        .frame(height: 60)
        .clipped()
    }
}
