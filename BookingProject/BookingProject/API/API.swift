import Foundation
import Nuke

final class API {
    
    static let shared = API()
    private let storage = Storage.shared
    
    func getData(url: String) -> Data {
        guard let url = URL(string: url) else { fatalError() }
        do {
            let data = try Data(contentsOf: url, options: .uncached)
            storage.cache.setObject(NSData(data: data), forKey: url as NSURL)
            return data
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    final func loadImage(_ url: URL) -> UIImage? {
        let semaphore = DispatchSemaphore(value: 0)
        var _result: PlatformImage?
        
        let request = ImageRequest(url: url, priority: .high)
        
        ImagePipeline.shared.loadImage(with: request, completion: { response in
            switch response {
            case .success(let result):
                _result = result.image
                semaphore.signal()
            case .failure(let error):
                print(error.localizedDescription)
                semaphore.signal()
            }
        })
        semaphore.wait()
        return _result
    }
    
    final func loadImageData(_ url: URL) -> Data? {
        
        let data: Data
        
        if let nsdata = storage.cache.object(forKey: url as NSURL) {
            data = Data(referencing: nsdata)
            return data
        } else {
            do {
                data = try Data(contentsOf: url, options: [.dataReadingMapped, .uncached])
                let nsdata = NSData(data: data)
                storage.cache.setObject(nsdata, forKey: url as NSURL); print(data, Date())
                return data
            } catch {
                return nil
            }
        }
    }
    private init() { }
}
