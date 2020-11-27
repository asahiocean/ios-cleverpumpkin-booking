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
                hotels[i].image = API.shared.loadImage(url)
            }
            return hotels as? [T]
        } catch {
            fatalError("Couldn't parse \([T].self):\n\(error.localizedDescription)")
        }
    }
    private init() { }
}

final class Storage {
    public static var shared = Storage()
    internal(set) public var hotels: [Hotel]?
    
    let quene = DispatchQueue(label: "com.storage.setdb")
    let group = DispatchGroup()

    func set(hotels: [Hotel]) {
        group.enter()
        quene.async(group: group, execute: { [self] in
            self.hotels = hotels
        })
        group.notify(queue: .main, execute: {
            print("group.notify")
            updaterGroup.leave()
        })
    }
}
