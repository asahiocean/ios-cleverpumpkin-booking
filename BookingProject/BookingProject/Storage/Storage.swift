import Foundation
import Dispatch

final class Storage {

    public static var shared = Storage()
    private init() {}

    public var userDefaults = UserDefaults.standard
    
    public var hotels: [Hotel]?
    private(set) public var hotels_sort_default: [Hotel]!
    private(set) public var hotels_sort_dist_ascend: [Hotel]!
    private(set) public var hotels_sort_dist_descend: [Hotel]!
    private(set) public var hotels_sort_rooms_ascend: [Hotel]!
    private(set) public var hotels_sort_rooms_descend: [Hotel]!
        
    final func setdata(_ data: Data) {
        hotels = Handler.codableArray(data)
        updaterGroup.leave()
        
        let sorterDispatchQueue = DispatchQueue(label: "com.storage.sorterDispatchQueue", qos: .background)
        sorterDispatchQueue.asyncAfter(deadline: .now() + 0.25, execute: { self.hotelsSorter() })
    }
}

extension Storage {
    final private func hotelsSorter() {
        guard let hotels = self.hotels else { return }
        hotels_sort_default = hotels
        hotels_sort_dist_ascend = hotels.sorted(by: {$0.distance < $1.distance})
        hotels_sort_dist_descend = hotels.sorted(by: {$0.distance > $1.distance})
        hotels_sort_rooms_ascend = hotels.sorted(by: {$0.availableRooms > $1.availableRooms})
        hotels_sort_rooms_descend = hotels.sorted(by: {$0.availableRooms < $1.availableRooms})
    }
}
