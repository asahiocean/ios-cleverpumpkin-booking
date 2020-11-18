import Foundation
import UIKit.UIImage

@objcMembers public class Hotel: NSObject, Codable, Identifiable {
    public var id: Int
    var name: String
    var address: String
    var stars: Int
    var distance: Double
    var suitesAvailability: String
    
    var image: UIImage
    
    enum CodingKeys: String, CodingKey {
        case id, name, address, stars, distance
        case suitesAvailability = "suites_availability"
    }

    init(id: Int?, name: String?, address: String?, stars: Int?, distance: Double?, suitesAvailability: String?) {
        self.id = id ?? 0
        self.name = name ?? ""
        self.address = address ?? ""
        self.stars = stars ?? 0
        self.distance = distance ?? 0.0
        self.suitesAvailability = suitesAvailability ?? ""
        
        self.image = UIImage()
    }
        
    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        address = try values.decode(String.self, forKey: .address)
        stars = try values.decode(Int.self, forKey: .stars)
        distance = try values.decode(Double.self, forKey: .distance)
        suitesAvailability = try values.decode(String.self, forKey: .suitesAvailability)
        image = UIImage()
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(address, forKey: .address)
        try container.encode(stars, forKey: .stars)
        try container.encode(distance, forKey: .distance)
        try container.encode(suitesAvailability, forKey: .suitesAvailability)
    }
}
