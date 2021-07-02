import Foundation
import UIKit

let screenBounds = UIScreen.main.bounds

enum TableConfig {
    static let width: CGFloat = screenBounds.width
    static let rowHeight: CGFloat = screenBounds.height / 10
    static let estimatedRowHeight: CGFloat = screenBounds.height / 10
    static let decelerationRate: UIScrollView.DecelerationRate = .fast
    static let autoresizingMask: UIView.AutoresizingMask =  [.flexibleWidth, .flexibleHeight]
}
