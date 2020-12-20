import Foundation

enum URLs {
    static let get: String = "https://raw.githubusercontent.com/iMofas/ios-android-test/master/0777.json"
}
extension URLs {
    static func details(_ id: Int) -> String { "https://raw.githubusercontent.com/iMofas/ios-android-test/master\(id).json" }
    static func image(_ i: Int) -> String { "https://github.com/iMofas/ios-android-test/raw/master/\(i).jpg" }
}
