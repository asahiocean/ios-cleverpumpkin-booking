import Foundation

final class Storage {
    public static var shared = Storage()
    internal(set) public var hotels: [Hotel]?
    public let cache = NSCache<NSURL, NSData>()
    
    func set(data: Data) {
        self.hotels = Handler.genericData(data)
        updaterGroup.leave()
    }
}
