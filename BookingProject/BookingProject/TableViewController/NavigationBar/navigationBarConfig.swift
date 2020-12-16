import Foundation
import UIKit

extension TableViewController {
    var rightBarButtonMenu: UIMenu {
        return UIMenu(title: "Сотрировка", children: [
            UIAction(title: "По умолчанию", image: UIImage(systemName: "arrow.clockwise", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal), handler: { [self] _ -> Void in

                DispatchQueue.main.async { tableView.reloadData() }
            }),
            UIAction(title: "Свободные комнаты", image: UIImage(systemName: "bed.double.fill", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal), handler: { [self] _ -> Void in

                DispatchQueue.main.async { tableView.reloadData() }
            }),
            UIAction(title: "Расстояние от центра", image: UIImage(systemName: "location.north.fill", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal), handler: { [self] _ -> Void in
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

            DispatchQueue.main.async { tableView.reloadData() }
        }
        
        let distance = UIAlertAction(title: "By distance", style: .default) { [self] (action) -> Void in

            DispatchQueue.main.async { tableView.reloadData() }
        }
        
        let _default = UIAlertAction(title: "By default", style: .default) { [self] (action) -> Void in

            DispatchQueue.main.async { tableView.reloadData() }
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
}
