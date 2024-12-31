//
//  ENDGMEApp.swift
//  ENDGME
//
//  Created by Chase Kessler on 12/28/24.
//

import SwiftUI

@main
struct ENDGMEApp: App {
    @StateObject private var authService = AuthService()
    @StateObject private var databaseService = DatabaseService()
    @StateObject private var navigationManager = NavigationPathManager()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(authService)
                .environmentObject(databaseService)
                .environmentObject(navigationManager)
        }
    }
}
