import Foundation
import Nuke
import UIKit

final class API {
    
    static let shared = API()
    
    func getData(url: String) -> Data {
        do {
            guard let url = URL(string: url) else { fatalError("CRASH URL") }
            return try Data(contentsOf: url)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func loadImage(_ url: URL, _ completion: @escaping (UIImage)->()){
        let request = ImageRequest(url: url, priority: .high)
        if let cached = ImagePipeline.shared.cachedImage(for: request) {
            completion(cached.image);
        } else {
            ImagePipeline.shared.loadImage(with: request, completion: { response in
                switch response {
                case let .success(result):
                    completion(result.image);
                case let .failure(error): // see breakpoint
                    if let image = UIImage(named: "imagecomingsoon") {
                        completion(image)
                    }
                }
            })
        }
    }
    
    private init() { }
}
