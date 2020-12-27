import Foundation
import UIKit.UIImage

class Hotel: Codable, Identifiable, Hashable {
    public var id: Int
    var name: String
    var address: String
    var stars: Int
    var distance: Double
    var suitesAvailability: String
    var availableRooms: Int
    
    var details: Details?
    var image: UIImage
    
    init(id: Int?, name: String?, address: String?, stars: Int?, distance: Double?, suitesAvailability: String?) {
        self.id = id ?? 0
        self.name = name ?? ""
        self.address = address ?? ""
        self.stars = stars ?? 0
        self.distance = distance ?? 0.0
        self.suitesAvailability = suitesAvailability ?? ""
        
        self.image = .init()
        self.availableRooms = suitesAvailability?.split(separator: ":").compactMap{Int($0)}.count ?? 0
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case address = "address"
        case stars = "stars"
        case distance = "distance"
        case suitesAvailability = "suites_availability"
    }
    
    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        address = try values.decode(String.self, forKey: .address)
        stars = try values.decode(Int.self, forKey: .stars)
        distance = try values.decode(Double.self, forKey: .distance)
        suitesAvailability = try values.decode(String.self, forKey: .suitesAvailability)
        
        image = .init()
        availableRooms = try values.decode(String.self, forKey: .suitesAvailability).split(separator: ":").compactMap{Int($0)}.count
    }
}

extension Hotel {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public static func == (lhs: Hotel, rhs: Hotel) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name && lhs.address == rhs.address && lhs.stars == rhs.stars && lhs.distance == rhs.distance && lhs.suitesAvailability == rhs.suitesAvailability && lhs.image == rhs.image && lhs.availableRooms == rhs.availableRooms
    }
}
