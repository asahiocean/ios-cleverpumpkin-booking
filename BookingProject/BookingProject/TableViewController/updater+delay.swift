import SwiftUI

extension TableViewController {
    
    static var delayscreen: UIHostingController<DelayScreen>?
    
    internal func delayScreen() {
        let screen = DelayScreen()
        Self.delayscreen = UIHostingController(rootView: screen)
        if let host = Self.delayscreen {
            host.isModalInPresentation = false
            host.modalPresentationStyle = .fullScreen
            present(host, animated: true, completion: nil)
        }
    }
    
    internal func updaterHotels() {
        updaterGroup.enter()
        if let data = API.shared.getData(url: URLs.get) {
            print("Start, \(Date())")
            updaterQueue.async(group: updaterGroup, execute: { [self] in
                storage.setdata(data)
            })
            updaterGroup.notify(queue: .main, execute: { [self] in
                tableView.reloadData()
                print("End, \(Date())")
            })
        }
    }
}
