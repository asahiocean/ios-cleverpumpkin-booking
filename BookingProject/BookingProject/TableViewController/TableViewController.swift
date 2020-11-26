import UIKit
import SwiftUI

class TableViewController: UITableViewController {
    
    internal var hotels: [Hotel]?
    var interactionMap: UIContextMenuInteraction!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let data = API.shared.getData(url: URLs.get)
        self.hotels = Handler.genericData(data)
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
        return hotels?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = (tableView.dequeueReusableCell(withIdentifier: CustomCell.id, for: indexPath) as? CustomCell) else { fatalError() }
        if let hotel = hotels?[indexPath.row] {
            cell.set(hotel: hotel)
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let navcon = navigationController else { return }
        if let hotel = hotels?[indexPath.row] {
            let detailinfo = DetailScreen(hotel: hotel)
            let hostVC = UIHostingController(rootView: detailinfo)
            navcon.pushViewController(hostVC, animated: true)
        }
    }
}

extension TableViewController {
    var rightBarButtonMenu: UIMenu {
        return UIMenu(title: "Сотрировка", children: [
            UIAction(title: "По умолчанию", image: UIImage(systemName: "arrow.clockwise", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal), handler: { _ in
                
            }),
            UIAction(title: "Свободные комнаты", image: UIImage(systemName: "bed.double.fill", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal), handler: { [self] _ -> Void in
                hotels = hotels?.sorted(by: {$0.distance < $1.distance})
                DispatchQueue.main.async { tableView.reloadData() }
            }),
            UIAction(title: "Расстояние от центра", image: UIImage(systemName: "location.north.fill", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal), handler: { [self] _ -> Void in
                _ = hotels?.sorted(by: {$0.distance < $1.distance})
                DispatchQueue.main.async { tableView.reloadData() }
            })
        ])
    }
    
    var rightBarButton: UIBarButtonItem {
        return UIBarButtonItem(title: "Sort", image: NAVBar.sortIcon, primaryAction: nil, menu: rightBarButtonMenu)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let navbar = navigationController?.navigationBar, navbar.largeTitleHeight > 0 else { return }
        if navbar.largeTitleHeight > 35 {
            navbar.topItem?.rightBarButtonItem = nil
            NAVBar.sortButton.isHidden = false
        } else {
            navbar.topItem?.rightBarButtonItem = rightBarButton
            NAVBar.sortButton.isHidden = true
        }
    }
    
    internal func navigationBarConfig() {
        navigationItem.title = "Hotels"
        
        guard let navigationController = navigationController else { fatalError() }
        navigationController.navigationItem.largeTitleDisplayMode = .always
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationBar.sizeToFit()
        
        let navigationBar = navigationController.navigationBar
        navigationBar.isTranslucent = true
        
        let button = NAVBar.sortButton
        button.addTarget(self, action: #selector(rightButtonTapped(_:)), for: .touchUpInside)
        navigationBar.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.rightAnchor.constraint(equalTo: navigationBar.rightAnchor, constant: -16.0),
            button.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: -12.0),
            button.heightAnchor.constraint(equalToConstant: navigationBar.bounds.height / 2),
            button.widthAnchor.constraint(equalTo: button.heightAnchor)
        ])
    }
    
    @objc func rightButtonTapped(_ action: UIAction) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let availableRooms = UIAlertAction(title: "By available rooms", style: .default) { [self] (action) -> Void in
            hotels = hotels?.sorted(by: {$0.distance < $1.distance})
            DispatchQueue.main.async { tableView.reloadData() }
        }
        
        let distance = UIAlertAction(title: "By distance", style: .default) { [self] (action) -> Void in
            _ = hotels?.sorted(by: {$0.distance < $1.distance})
            DispatchQueue.main.async { tableView.reloadData() }
        }
        
        let _default = UIAlertAction(title: "By default", style: .default) { [self] (action) -> Void in
            print("default")
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { [self] (action) -> Void in
            print("Cancel")
        }
        
        actionSheet.addAction(availableRooms)
        actionSheet.addAction(distance)
        actionSheet.addAction(_default)
        actionSheet.addAction(cancel)
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    internal func tableViewConfig() {
        tableView.layoutIfNeeded()
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.rowHeight = TView.rowHeight
        tableView.estimatedRowHeight = TView.estimatedRowHeight
        tableView.decelerationRate = .fast
        navigationBarConfig()
    }
}
