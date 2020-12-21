import Foundation
import Dispatch

final class API {
    
    static let shared = API()
    private let storage = Storage.shared
        
    func load(from urlString: String) -> Data? {
        guard let url = URL(string: urlString) else { fatalError() }
        
        var data: Data?
        
        let semaphore = DispatchSemaphore(value: 0)
        let QoS = DispatchQoS(qosClass: .userInitiated, relativePriority: 100)
        let queue = DispatchQueue(label: "com.api.loadData", qos: QoS, attributes: .concurrent)
        
        queue.async { [self] in
            if let cacheddata = UserDefaults.standard.data(forKey: url.absoluteString) {
                data = cacheddata
                semaphore.signal()
            } else {
                do {
                    let loaddata = try Data(contentsOf: url, options: .mappedRead) // [.uncached, .uncachedRead, .mappedRead]
                    storage.userDefaults.set(loaddata, forKey: url.absoluteString)
                    data = loaddata
                    semaphore.signal()
                } catch {
                    data = nil
                    semaphore.signal()
                }
            }
        }
        semaphore.wait()
        storage.userDefaults.synchronize()
        return data
    }
    
    private init() { }
}
