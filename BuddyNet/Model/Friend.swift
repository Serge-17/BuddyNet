import SwiftData
import SwiftUI


struct Friend: Codable, Identifiable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }

        var id: UUID
        var name: String

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
    }
}
