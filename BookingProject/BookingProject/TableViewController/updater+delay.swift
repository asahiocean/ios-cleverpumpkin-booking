import SwiftUI

extension TableViewController {
        
    static fileprivate var loadview: UIView = {
        var view =  UIView()
        view.clipsToBounds = true
        let rootView = UIHostingController(rootView: DelayScreen())
        if let rootView = rootView.view { view = rootView }
        return view
    }()

    internal func loadview() {
        DispatchQueue.main.async {
            let tvb = self.tableView.bounds
            let lv = Self.loadview
            lv.bounds.size = CGSize(width: tvb.width, height: tvb.height)
            lv.center = CGPoint(x: tvb.midX, y: tvb.midY)
            self.view.addSubview(Self.loadview)
        }
    }
    
    internal func updaterHotels() {
        DispatchQueue.main.async {
            self.title = "Looking for hotels..."
            NAVBar.sortButton.isHidden = true
        }
        updaterGroup.enter()
        if let data = API.shared.get(from: URLs.get) {
            updaterQueue.async(group: updaterGroup, execute: {
                self.storage.setdata(data)
            })
            updaterGroup.notify(queue: .main, execute: {
                self.tableView.reloadData()
                Self.loadview.removeFromSuperview()
                NAVBar.sortButton.isHidden = false
                self.title = "Hotels"
            })
        }
    }
}
