import Foundation
import UIKit.UIImage

final class API {
    
    static let shared = API()
    private let storage = Storage.shared
    
    func loadData(from url: String) -> Data? {
        guard let url = URL(string: url) else { fatalError() }
        
        let semaphore = DispatchSemaphore(value: 0)
        let resultData: Data?
        
        if let cachedData = UserDefaults.standard.data(forKey: url.absoluteString) {
            resultData = cachedData
            semaphore.signal()
        } else {
            do {
                let newData = try Data(contentsOf: url, options: [.uncachedRead,.mappedRead])
                storage.userDefaults.set(newData, forKey: url.absoluteString)
                resultData = newData
                semaphore.signal()
            } catch {
                resultData = nil
                semaphore.signal()
            }
        }
        semaphore.wait()
        storage.userDefaults.synchronize()
        return resultData
    }
    
    private init() { }
}
