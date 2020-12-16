import SwiftUI

final class HostingCell<Content: View>: UITableViewCell {
    private let host = UIHostingController<Content?>(rootView: nil)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        host.view.frame.size = bounds.size // host.sizeThatFits(in: bounds.size)
    }

    public func set(rootView: Content) {
        host.rootView = rootView
        if !contentView.subviews.contains(host.view) { contentView.addSubview(host.view) }
    }
}
