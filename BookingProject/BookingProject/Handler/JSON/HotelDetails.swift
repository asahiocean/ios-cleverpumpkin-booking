import Foundation

public struct Details: Codable, Identifiable, Hashable {
    
    public var id: Int?
    var name: String?
    var address: String?
    var stars: Int?
    var distance: Double?
    var image: String?
    var suitesAvailability: String?
    var lat: Double?
    var lon: Double?
    
    init(from dict: NSDictionary) {
        id = dict["id"] as? Int
        name = dict["name"] as? String
        address = dict["address"] as? String
        stars = dict["stars"] as? Int
        distance = dict["distance"] as? Double
        image = dict["image"] as? String
        suitesAvailability = dict["suites_availability"] as? String
        lat = dict["lat"] as? Double
        lon = dict["lon"] as? Double
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case address = "address"
        case stars = "stars"
        case distance = "distance"
        case image = "image"
        case suitesAvailability = "suites_availability"
        case lat = "lat"
        case lon = "lon"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        address = try values.decode(String.self, forKey: .address)
        stars = try values.decode(Int.self, forKey: .stars)
        distance = try values.decode(Double.self, forKey: .distance)
        image = try values.decode(String.self, forKey: .image)
        suitesAvailability = try values.decode(String.self, forKey: .suitesAvailability)
        lat = try values.decode(Double.self, forKey: .lat)
        lon = try values.decode(Double.self, forKey: .lon)
    }
}

extension Details {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public static func == (lhs: Details, rhs: Details) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name && lhs.address == rhs.address && lhs.stars == rhs.stars && lhs.distance == rhs.distance && lhs.image == rhs.image && lhs.suitesAvailability == rhs.suitesAvailability && lhs.lat == rhs.lat && lhs.lon == rhs.lon
    }
}
