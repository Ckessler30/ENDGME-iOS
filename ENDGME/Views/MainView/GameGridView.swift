// Views/MainView/GameGridView.swift

import SwiftUI

struct GameGridView: View {
    @EnvironmentObject var databaseService: DatabaseService
    
    let columns = [
        GridItem(.flexible()),
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(databaseService.games) { game in
                    GameCardView(game: game){
                        print("Game selected")
                    }
                    
                    
                }
            }
            .padding()
        }
        .scrollBounceBehavior(.basedOnSize, axes: .vertical)
        .onAppear {
            Task {
                await databaseService.fetchGames()
            }
        }
    }
}

struct GameGridView_Previews: PreviewProvider {
    @StateObject static var databaseService = DatabaseService()
    static var previews: some View {
        GameGridView()
            .environmentObject(databaseService)
    }
}
