import SwiftUI
import UIKit

public let updaterQueue = DispatchQueue(label: "updater.queue")
public let updaterGroup = DispatchGroup()

class TableViewController: UITableViewController {
    
    public let storage = Storage.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadview()
        updaterHotels()
        tableView.register(UINib(nibName: CustomCell.id, bundle: nil), forCellReuseIdentifier: CustomCell.id)
        // tableView.register(HostingCell<Cell>.self, forCellReuseIdentifier: "HostingCell<CellView>")
        tableViewConfig()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.contentInset = UIEdgeInsets(top: 1, left: 0, bottom: 0, right: 0)
        NAVBar.sortButton.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NAVBar.sortButton.isHidden = true
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storage.hotels?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let hostcell = tableView.dequeueReusableCell(withIdentifier: "HostingCell<CellView>", for: indexPath) as! HostingCell<Cell>
        //if let hotel = storage.hotels?[indexPath.row] { hostcell.set(rootView: Cell(hotel: hotel)) }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.id, for: indexPath) as! CustomCell
        if let hotel = storage.hotels?[indexPath.row] { cell.set(hotel: hotel) }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let navcon = navigationController else { return }
        if let hotel = storage.hotels?[indexPath.row] {
            let detailinfo = DetailScreen(hotel: hotel)
            let hostVC = UIHostingController(rootView: detailinfo)
            navcon.pushViewController(hostVC, animated: true)
        }
    }
    
    //MARK: -- Context Menu
    override func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let config = UIContextMenuConfiguration(identifier: nil, previewProvider: { [self] () -> UIViewController? in
            
            let nib = UINib(nibName: PreviewHotel.id, bundle: Bundle(for: PreviewHotel.self))
            guard let preview = nib.instantiate(withOwner: nil, options: nil)[0] as? PreviewHotel,
                  let hotel = storage.hotels?[indexPath.row] else { return nil }
            preview.setImage(hotel.image)
            return preview
        }) { _ -> UIMenu? in
            let call = UIAction(title: "Позвонить", image: UIImage(systemName: "phone.fill", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)) { action in
                if let url = URL(string: "tel://+1-234-567-88-99"), UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
            return UIMenu(title: "", children: [call])
        }
        return config
    }
}
