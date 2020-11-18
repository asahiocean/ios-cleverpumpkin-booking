import UIKit
import SwiftUI

public var rowHeight: CGFloat = UIScreen.main.bounds.height/10
public var estimatedRowHeight: CGFloat = UIScreen.main.bounds.height/10

class TableViewController: UITableViewController {
    
    private var hotels: [Hotel]!
    var interactionMap: UIContextMenuInteraction!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        hotels = Handler.getdb()
        tableView.register(CustomCell.nib, forCellReuseIdentifier: CustomCell.identifier)
        setup()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hotels.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = (tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier, for: indexPath) as? CustomCell) {
            cell.hotel(hotels[indexPath.row])
            return cell
        } else {
            let cell = UITableViewCell(style: .value1, reuseIdentifier: CustomCell.identifier)
            cell.backgroundColor = UIColor.systemRed
            return cell
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailScreen = DetailScreen(object: hotels[indexPath.row])
        let host = UIHostingController(rootView: detailScreen)
        navigationController?.pushViewController(host, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        func contextMenu() -> UIMenu {
            let call = UIAction(title: "Позвонить", image: UIImage(systemName: "phone.fill", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))) { action in
                
                if let url = URL(string: "tel://+1-234-567-88-99"),
                    UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
            return UIMenu(title: "", children: [call])
        }
        let config = UIContextMenuConfiguration(
            identifier: nil,
            previewProvider: { () -> UIViewController? in
            
            let vc = UINib(nibName: PreviewHotelImage.identifier, bundle: Bundle(for: PreviewHotelImage.self)).instantiate(withOwner: nil, options: nil).first as? PreviewHotelImage
                
            let hotel = self.hotels[indexPath.row]
            let name = hotel.name.replacingOccurrences(of: " ", with: "%20")
            let url = "https://dummyimage.com/400/\(hotel.id)/ffffff&text=\(name)"
            
            vc?.setImage(url)
            
            return vc
        }) { _ -> UIMenu? in
            return contextMenu()
        }
        return config
    }
}

extension TableViewController {
    internal func setup() {
        activityIndicator()
        tableViewConfig()
        navigationBar()
    }
    
    internal func activityIndicator() {
        let activityView = UIActivityIndicatorView(style: .large)
        tableView.backgroundView = activityView
        activityView.startAnimating()
    }
    
    internal func navigationBar() {
        navigationItem.title = "Hotels"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    internal func tableViewConfig() {
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.rowHeight = rowHeight
        tableView.estimatedRowHeight = estimatedRowHeight
        tableView.decelerationRate = .fast
    }
}
