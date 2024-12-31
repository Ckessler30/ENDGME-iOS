import SwiftUI

struct GameCardView: View {
    let game: Game
    let onTap: () -> Void
    
    var body: some View {
        Button(action: {
            onTap()
        }) {
                ImageLoader(imageURL: game.imageURL, resizingMode: .fill)
                    .scaledToFit()
                    .cornerRadius(12)
                    .clipped()
                    
        }
        .buttonStyle(DefaultButtonStyle())
        .cornerRadius(12)
        .shadow(radius: 4)
    }
}

struct GameCardView_Previews: PreviewProvider {
    static var previews: some View {
        GameCardView(
            game: Game(
                id: UUID(),
                name: "Marvel Rivals",
                description: "test",
                imageURL: "https://vzzcvnumbdwgdacylodk.supabase.co/storage/v1/object/sign/marvel-rivals/marvel-rivals-cover.jpg?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1cmwiOiJtYXJ2ZWwtcml2YWxzL21hcnZlbC1yaXZhbHMtY292ZXIuanBnIiwiaWF0IjoxNzM1NDE2NjQyLCJleHAiOjE3NjY5NTI2NDJ9.va8CubYWmaOVc8iUln7XAAiEOe7V4MfFufNDyH7RpjA&t=2024-12-28T20%3A10%3A42.078Z"
            )
        ) {
            print("Game tapped!") // Example action for preview
        }
        
    }
}
