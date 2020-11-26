import UIKit

protocol Json {
    static func genericData<T: Codable>(_ data: Data) -> [T]?
}

final class Handler: Json {
    static func genericData<T: Codable>(_ data: Data) -> [T]? {
        do {
            let raw = try newJSONDecoder().decode([T].self, from: data)
            guard let hotels = raw as? [Hotel] else { fatalError("NOT HOTELS") }
            for i in hotels.indices {
                if let url: URL = URL(string: "https://github.com/iMofas/ios-android-test/raw/master/\(i+1).jpg") {
                    API.shared.loadImage(url, { image in
                        hotels[i].image = image
                    })
                }
            }
            return hotels as? [T]
        } catch {
            fatalError("Couldn't parse \([T].self):\n\(error.localizedDescription)")
        }
    }
    private init() { }
}
