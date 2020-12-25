import SwiftUI

final class HostingCell<Content: View>: UITableViewCell {
    private let host = UIHostingController<Content?>(rootView: nil)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder decoder: NSCoder) {
        guard decoder == .none else { fatalError("init(coder:) has not been implemented") }
        super.init(coder: decoder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        host.view.frame.size = bounds.size
    }

    public func set(rootView: Content) {
        host.rootView = rootView
        contentView.addSubview(host.view)
        if !contentView.subviews.contains(host.view) {
            contentView.addSubview(host.view)
        }
    }
}
