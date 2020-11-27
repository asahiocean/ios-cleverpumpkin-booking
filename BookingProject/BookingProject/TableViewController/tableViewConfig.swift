import Foundation
import UIKit

extension TableViewController {
    internal func tableViewConfig() {
        tableView.layoutIfNeeded()
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.rowHeight = UIScreen.main.bounds.height/10
        tableView.estimatedRowHeight = UIScreen.main.bounds.height/10
        tableView.decelerationRate = .fast
        navigationBarConfig()
    }
}