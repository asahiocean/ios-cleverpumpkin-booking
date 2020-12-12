import SwiftUI
import UIKit

public let updaterQueue = DispatchQueue(label: "updater.queue")
public let updaterGroup = DispatchGroup()

class TableViewController: UITableViewController {
    
    var interactionMap: UIContextMenuInteraction!
    let storage = Storage.shared

    override func viewDidLoad() {
        super.viewDidLoad()
//        delayScreen()
        updaterHotels()
        tableView.register(CustomCell.nib, forCellReuseIdentifier: CustomCell.id)
        tableViewConfig()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.contentInset = UIEdgeInsets(top: 1, left: 0, bottom: 0, right: 0)
        UIView.animate(withDuration: 0.15, animations: { NAVBar.sortButton.alpha = 1 })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIView.animate(withDuration: 0.15, animations: { NAVBar.sortButton.alpha = 0 })
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storage.hotels?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.id, for: indexPath) as? CustomCell else { fatalError() }
        if let hotel = storage.hotels?[indexPath.row] { cell.setHotel(hotel) }
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let navcon = navigationController else { return }
        if let hotel = storage.hotels?[indexPath.row] {
            let detailinfo = DetailScreen(hotel: .constant(hotel))
            //let detailinfo = DetailScreen(hotel: hotel)
            let hostVC = UIHostingController(rootView: detailinfo)
            navcon.pushViewController(hostVC, animated: true)
        }
    }
}
