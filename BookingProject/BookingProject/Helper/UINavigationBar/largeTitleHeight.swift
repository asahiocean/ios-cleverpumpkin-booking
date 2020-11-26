import Foundation
import UIKit.UINavigationBar

extension UINavigationBar {
    var largeTitleHeight: CGFloat {
        let maxsize = subviews
            .filter { $0.frame.origin.y > 0 }
            .max { $0.frame.origin.y < $1.frame.origin.y }
            .map { $0.frame.size }
        return maxsize?.height ?? 0
    }
}
