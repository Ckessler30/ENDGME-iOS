//
//  SDWebImageLoader.swift
//  ENDGME
//
//  Created by Chase Kessler on 12/31/24.
//
import SwiftUI
import SDWebImageSwiftUI

struct ImageLoader: View {
    var imageURL: String
    var resizingMode: ContentMode = .fill

    var body: some View {
        WebImage(url: URL(string: imageURL))
            .resizable()
            .indicator(.activity)
            .transition(.fade(duration: 0.5))
            .aspectRatio(contentMode: resizingMode)
            .clipped() // Ensure content respects boundaries
    }
}

#Preview {
    ImageLoader(
        imageURL: "https://vzzcvnumbdwgdacylodk.supabase.co/storage/v1/object/sign/marvel-rivals/marvel-rivals-cover.jpg?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1cmwiOiJtYXJ2ZWwtcml2YWxzL21hcnZlbC1yaXZhbHMtY292ZXIuanBnIiwiaWF0IjoxNzM1NDE2NjQyLCJleHAiOjE3NjY5NTI2NDJ9.va8CubYWmaOVc8iUln7XAAiEOe7V4MfFufNDyH7RpjA&t=2024-12-28T20%3A10%3A42.078Z",
        resizingMode: .fit
    )
    .padding(20)
}
