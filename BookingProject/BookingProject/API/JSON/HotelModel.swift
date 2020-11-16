import Foundation

// MARK: - Hotel
@objcMembers public class Hotel: NSObject, Codable {
    var id: Int?
    var name: String?
    var address: String?
    var stars: Int?
    var distance: Double?
    var suitesAvailability: String?

    enum CodingKeys: String, CodingKey {
        case id, name, address, stars, distance
        case suitesAvailability = "suites_availability"
    }

    init(id: Int?, name: String?, address: String?, stars: Int?, distance: Double?, suitesAvailability: String?) {
        self.id = id
        self.name = name
        self.address = address
        self.stars = stars
        self.distance = distance
        self.suitesAvailability = suitesAvailability
    }
        
    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        address = try values.decode(String.self, forKey: .address)
        stars = try values.decode(Int.self, forKey: .stars)
        distance = try values.decode(Double.self, forKey: .distance)
        suitesAvailability = try values.decode(String.self, forKey: .suitesAvailability)
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

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}

// MARK: - URLSession response handlers

extension URLSession: CodableTask {
    public func codableTask<T: Codable>(with url: URL, completion: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil, response, error)
                return
            }
            completion(try? newJSONDecoder().decode(T.self, from: data), response, nil)
        }
    }
}

protocol CodableTask {
    func codableTask<T: Codable>(with url: URL, completion: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}
