import SwiftData
import SwiftUI

struct User: Codable, Identifiable {
    let id: UUID
    let isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let registered: Date
    let tags: [String]
    let friends: [Friend]
}
