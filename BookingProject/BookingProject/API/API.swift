import Foundation

struct API {
    
    static let shared = API()
    private let storage = Storage.shared
    
    public func get(from urlString: String) -> Data? {
        let url = URL(string: urlString)!
        var data: Data?
        
        let operation = BlockOperation(block: {
            if let cachedData = UserDefaults.standard.data(forKey: url.absoluteString) {
                data = cachedData
            } else {
                do {
                    let newdata = try Data(contentsOf: url, options: [.uncached,.uncachedRead,.mappedRead])
                    defer {
                        storage.userDefaults.set(newdata, forKey: url.absoluteString);
                        storage.userDefaults.synchronize();
                    }
                    data = newdata
                } catch {
                    data = nil
                }
            }
        })
        operation.queuePriority = .veryHigh
        operation.qualityOfService = .userInitiated
        
        let queue = OperationQueue()
        queue.qualityOfService = .userInitiated
        
        queue.addOperations([operation], waitUntilFinished: true)
        return data
    }
    
    public func post(to urlString: String, body: [String:Any]) {
        let url = URL(string: urlString)!
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            guard error == nil, let data = data else { return }            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    print(json)
                }
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()

    }
    
    private init() { }
}
