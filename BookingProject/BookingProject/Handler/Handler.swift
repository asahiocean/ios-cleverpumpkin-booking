import UIKit

protocol Json {
    static func dataToArray<T: Codable>(_ data: Data) -> [T]?
}

final class Handler: Json {
    static func dataToArray<T: Codable>(_ data: Data) -> [T]? {
        do {
            let raw = try newJSONDecoder().decode([T].self, from: data)
            guard let hotels = raw as? [Hotel] else { return nil }
            
            for i in hotels.indices {
                let data = API.shared.loadData(from: URLs.image(i+1))
                switch data {
                case nil:
                    if let image = UIImage(named: "imagecomingsoon") { hotels[i].image = image }
                default:
                    if let data = data { hotels[i].image = UIImage(data: data)!.crop(w: 1, h: 1) }
                }
            }
            return hotels as? [T]
        } catch {
            fatalError("Couldn't parse \([T].self):\n\(error.localizedDescription)")
        }
    }
    private init() { }
}
