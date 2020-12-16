import Foundation

extension TableViewController {
    internal func tableViewConfig() {
        tableView.layoutIfNeeded()
        tableView.autoresizingMask = TableConfig.autoresizingMask
        tableView.rowHeight = TableConfig.rowHeight
        tableView.estimatedRowHeight = TableConfig.estimatedRowHeight
        tableView.decelerationRate = TableConfig.decelerationRate
        navigationBarConfig()
    }
}
