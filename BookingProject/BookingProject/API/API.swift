import Foundation
import UIKit

final class API {
    
    static let shared = API()
    let cache = NSCache<NSURL, UIImage>()
    
    func getData(url: String) -> Data {
        do {
            let url = URL(string: url)!
            return try Data(contentsOf: url)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func loadImage(_ url: URL) -> UIImage {
        if let image = cache.object(forKey: url as NSURL) {
            return image
        } else if let data = try? Data(contentsOf: url, options: .uncached), let image = UIImage(data: data) {
            cache.setObject(image, forKey: url as NSURL)
            return image
        }
        return UIImage(named: "imagecomingsoon")!
    }
    private init() { }
}
