import Foundation

final class Handler {
    static func getdb<T: Codable>() -> [T] {
        
        let data: Data = API.get(URLs.get)
        
        do {
            return try newJSONDecoder().decode([T].self, from: data)
        } catch {
            fatalError("Couldn't parse \(T.self):\n\(error)")
        }
    }
    private init() { }
}
