import Foundation
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
                guard let url = URL(string: "https://github.com/iMofas/ios-android-test/raw/master/\(i+1).jpg") else { fatalError() }
                if let imagedata = API.shared.loadImageData(url) {
                    hotels[i].imagedata = imagedata
                } else {
                    if let data = UIImage(named: "imagecomingsoon")?.pngData() {
                        hotels[i].imagedata = data
                    }
                }
            }
            sleep(1)
            return hotels as? [T]
        } catch {
            fatalError("Couldn't parse \([T].self):\n\(error.localizedDescription)")
        }
    }
    private init() { }
}
