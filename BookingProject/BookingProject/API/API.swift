import Foundation
import Dispatch

struct API {
    
    static let shared = API()
    private let storage = Storage.shared
    
    public func get(from urlString: String) -> Data? {
        let url = URL(string: urlString)!
        var data: Data?
        
        let semaphore = DispatchSemaphore(value: 0)
        
        if let cachedData = UserDefaults.standard.data(forKey: url.absoluteString) {
            data = cachedData
            semaphore.signal()
        } else {
            do {
                let newdata = try Data(contentsOf: url, options: .mappedRead)
                defer {
                    storage.userDefaults.set(newdata, forKey: url.absoluteString);
                    storage.userDefaults.synchronize();
                }
                data = newdata
                semaphore.signal()
            } catch {
                data = nil
                semaphore.signal()
            }
        }
        
        semaphore.wait()
        return data
    }
    
    public func post(to urlString: String, body: [String:Any]) {
        let url = URL(string: urlString)!
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [.prettyPrinted])
        } catch let error {
            print(error.localizedDescription)
        }
        
        session.dataTask(with: request, completionHandler: { (data,response,error) in
            guard error == nil, let data = data, let answer = String(data: data, encoding: .utf8) else { return }
            print(answer)
        }).resume()
    }
    
    private init() { }
}
