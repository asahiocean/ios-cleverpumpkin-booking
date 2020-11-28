import Foundation
import SwiftUI

extension TableViewController {
    internal func delayScreen() {
        let screen = DelayScreen()
        let hostVC = UIHostingController(rootView: screen)
        hostVC.modalPresentationStyle = .fullScreen
        present(hostVC, animated: false, completion: { })
    }
    
    internal func updaterHotels() {
        updaterGroup.enter()
        let data = API.shared.getData(url: URLs.get)
        updaterQueue.async(group: updaterGroup, execute: { [self] in
            storage.setdata(data)
        })
        updaterGroup.notify(queue: .main, execute: { [self] in
            tableView.reloadData()
        })
    }
}
