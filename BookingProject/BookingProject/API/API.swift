import Foundation
import UIKit

final class API {
    
    static let shared = API()
    let cache = NSCache<NSURL, NSData>()
    
    func getData(url: String) -> Data {
        guard let url = URL(string: url) else { fatalError() }
        do {
            let data = try Data(contentsOf: url, options: .uncached)
            API.shared.cache.setObject(NSData(data: data), forKey: url as NSURL)
            return data
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func loadImage(_ url: URL) -> UIImage {
        if let nsdata = cache.object(forKey: url as NSURL), let image = UIImage(data: Data(referencing: nsdata)) {
            return image
        } else if let data = try? Data(contentsOf: url, options: .uncached), let image = UIImage(data: data) {
            cache.setObject(NSData(data: data), forKey: url as NSURL)
            return image
        }
        return UIImage(named: "imagecomingsoon")!
    }
    private init() { }
}
