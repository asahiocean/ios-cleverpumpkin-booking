import Foundation
import Nuke
import UIKit.UIImage

class API {
    static func get(_ url: String) -> Data {
        do {
            guard let url = URL(string: url) else { fatalError("CRASH URL") }
            return try Data(contentsOf: url)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    static func loadImage(_ urlSrt: String, _ completion: @escaping (UIImage?)->()) {
        guard let url = URL(string: urlSrt) else { return }
        
        let request = ImageRequest(url: url, priority: .high)
        if let cached = ImagePipeline.shared.cachedImage(for: request) {
            completion(cached.image);
        } else {
            ImagePipeline.shared.loadImage(with: request, completion: { response in
                switch response {
                case let .success(result):
                    completion(result.image);
                case let .failure(error):
                    print(error.localizedDescription)
                    completion(nil)
                }
            })
        }
    }
    
    private init() { }
}
