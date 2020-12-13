import Foundation
import UIKit.UIImage

final class API {
    
    static let shared = API()
    private let storage = Storage.shared
    
    func loadData(from url: String) -> Data? {
        guard let url = URL(string: url) else { fatalError() }
        
        let semaphore = DispatchSemaphore(value: 0)
        let data: Data
        
        do {
            data = try Data(contentsOf: url, options: [.uncachedRead,.mappedRead])
            let nsdata = NSData(data: data)
            storage.cache.setObject(nsdata, forKey: url as NSURL)
            semaphore.signal()
        } catch {
            data = .init()
            semaphore.signal()
        }
        
        semaphore.wait()
        return data
    }
        
    private init() { }
}
