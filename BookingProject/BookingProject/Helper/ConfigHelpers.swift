import Foundation
import UIKit

enum TableConfig {
    static let width: CGFloat = UIScreen.main.bounds.width
    static let rowHeight: CGFloat = UIScreen.main.bounds.height / 10
    static let estimatedRowHeight: CGFloat = UIScreen.main.bounds.height / 10
    static let decelerationRate: UIScrollView.DecelerationRate = .fast
    static let autoresizingMask: UIView.AutoresizingMask =  [.flexibleWidth, .flexibleHeight]
}
