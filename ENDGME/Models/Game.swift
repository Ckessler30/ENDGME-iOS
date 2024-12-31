// Models/Game.swift

import Foundation

struct Game: Identifiable, Codable {
    let id: UUID
    let name: String
    let description: String
    let imageURL: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case imageURL = "image_url"
    }
}
