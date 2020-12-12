import UIKit

protocol Json {
    static func genericData<T: Codable>(_ data: Data) -> [T]?
}

final class Handler: Json {
    static func genericData<T: Codable>(_ data: Data) -> [T]? {
        do {
            let raw = try newJSONDecoder().decode([T].self, from: data)
            guard let hotels = raw as? [Hotel] else { return nil }
            
            for i in hotels.indices {
                let urlStr = URLs.image(i+1)
                if let data = API.shared.imageData(url: urlStr) {
                    hotels[i].image = UIImage(data: data)!
                }
            }
            return hotels as? [T]
        } catch {
            fatalError("Couldn't parse \([T].self):\n\(error.localizedDescription)")
        }
    }
    private init() { }
}
