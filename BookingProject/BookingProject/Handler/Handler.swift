import UIKit

protocol Json {
    static func codableArray<T: Codable>(_ data: Data) -> [T]?
}

final class Handler: Json {
    static func codableArray<T: Codable>(_ data: Data) -> [T]? {
        do {
            let raw = try newJSONDecoder().decode([T].self, from: data)
            guard let hotels = raw as? [Hotel] else { return nil }
            
            for i in hotels.indices {
                let imageData = API.shared.get(from: URLs.image(i+1))
                hotels[i].image = imageData != nil ? UIImage(data: imageData!)!.crop(w: 1, h: 1) : UIImage(named: "imagecomingsoon")!
                
                if let detailsData = API.shared.get(from: URLs.details(hotels[i].id)),
                   let jsondict = try JSONSerialization.jsonObject(with: detailsData, options: []) as? NSDictionary {
                    hotels[i].details = .init(from: jsondict)
                }
            }
            return hotels as? [T]
        } catch {
            fatalError("Couldn't parse \([T].self):\n\(error.localizedDescription)")
        }
    }
    private init() { }
}
