import Foundation

final class API {
    
    static let shared = API()
    private let storage = Storage.shared
    
    final public func load(from urlString: String) -> Data? {
        let url = URL(string: urlString)!
        var data: Data?
        
        let operation = BlockOperation(block: {
            if let cachedData = UserDefaults.standard.data(forKey: url.absoluteString) {
                data = cachedData
            } else {
                do {
                    data = try Data(contentsOf: url, options: .mappedRead)
                } catch {
                    print(error.localizedDescription)
                }
            }
        })
        operation.queuePriority = .veryHigh
        operation.qualityOfService = .userInitiated
        
        let queue = OperationQueue()
        queue.qualityOfService = .userInitiated

        queue.addBarrierBlock { [self] in
            guard let safeData = data else { return }
            storage.userDefaults.set(safeData, forKey: url.absoluteString);
            storage.userDefaults.synchronize();
        }
        queue.addOperations([operation], waitUntilFinished: true)
        return data
    }
    
    private init() { }
}
