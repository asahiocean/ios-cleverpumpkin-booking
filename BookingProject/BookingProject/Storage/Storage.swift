import Foundation

final class Storage {
    public static var shared = Storage()
    internal(set) public var hotels: [Hotel]?
    public let cache = NSCache<NSURL, NSData>()
    
    let quene = DispatchQueue(label: "com.StorageManager.setdb")
    let group = DispatchGroup()
    
    func setdata(_ data: Data) {
        group.enter()
        quene.async(group: group, execute: { [self] in
            self.hotels = Handler.genericData(data)
            group.leave()
        })
        group.notify(queue: .main, execute: {
            updaterGroup.leave()
        })
    }
}
