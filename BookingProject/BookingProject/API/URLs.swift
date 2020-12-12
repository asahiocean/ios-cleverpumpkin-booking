import Foundation

enum URLs {
    static let get: String = "https://raw.githubusercontent.com/iMofas/ios-android-test/master/0777.json"
    static func image(_ index: Int) -> String {
        "https://github.com/iMofas/ios-android-test/raw/master/\(index).jpg"
    }
}
