import SwiftUI

class NavigationPathManager: ObservableObject {
    @Published var path: NavigationPath = NavigationPath()
}
