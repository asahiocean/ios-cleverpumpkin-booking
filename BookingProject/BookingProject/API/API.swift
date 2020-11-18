import Foundation

class API {
    static func get(_ url: String) -> Data {
        do {
            guard let url = URL(string: url) else { fatalError("CRASH URL") }
            return try Data(contentsOf: url)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    private init() { }
}
