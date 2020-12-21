import SwiftUI

extension TableViewController {
        
    static fileprivate var loadview: UIView = {
        var view =  UIView()
        view.clipsToBounds = true
        let screen = DelayScreen()
        let rootView = UIHostingController(rootView: screen)
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
        updaterGroup.enter()
        if let data = API.shared.load(from: URLs.get) {
            DispatchQueue.main.async {
                self.title = "Looking for hotels..."
                Self.loadview.isHidden = false
                NAVBar.sortButton.isHidden = true
            }
            updaterQueue.async(group: updaterGroup, execute: {
                self.storage.setdata(data)
            })
            updaterGroup.notify(queue: .main, execute: {
                self.tableView.reloadData()
                self.title = "Hotels"
                Self.loadview.isHidden = true
                NAVBar.sortButton.isHidden = false
            })
        }
    }
}
