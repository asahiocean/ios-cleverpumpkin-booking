import Foundation

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
    
    func loadImageData(_ url: URL) -> Data? {
        if let nsdata = storage.cache.object(forKey: url as NSURL) {
            let data = Data(referencing: nsdata)
            return data
        } else if let data = try? Data(contentsOf: url, options: .uncached) {
            let nsdata = NSData(data: data)
            storage.cache.setObject(nsdata, forKey: url as NSURL)
            return data
        }
        return nil
    }
    private init() { }
}
