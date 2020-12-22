import Foundation
import UIKit

extension TableViewController {
    fileprivate func defaultSort() {
        storage.hotels = storage.hotels_sort_default
        DispatchQueue.main.async(execute: { [self] in
            tableView.reloadData()
        })
    }
    
    fileprivate func availableRooms_ascend() {
        storage.hotels = storage.hotels_sort_rooms_ascend
        DispatchQueue.main.async(execute: { [self] in
            tableView.reloadData()
        })
    }
    
    fileprivate func distance_ascend() {
        storage.hotels = storage.hotels_sort_dist_ascend
        DispatchQueue.main.async(execute: { [self] in
            tableView.reloadData()
        })
    }
    
    var rightBarButtonMenu: UIMenu {
        return UIMenu(title: "Сотрировка", children: [
            UIAction(title: "По умолчанию", image: UIImage(systemName: "arrow.clockwise", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal), handler: { [self] _ -> Void in
                defaultSort()
            }),
            UIAction(title: "Свободные комнаты", image: UIImage(systemName: "bed.double.fill", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal), handler: { [self] _ -> Void in
                availableRooms_ascend()
            }),
            UIAction(title: "Расстояние от центра", image: UIImage(systemName: "location.north.fill", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal), handler: { [self] _ -> Void in
                distance_ascend()
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
        //MARK: -- By available rooms
        let availableRooms = UIAlertAction(title: "By available rooms", style: .default) { [self] (action) -> Void in
            availableRooms_ascend()
        }
        //MARK: -- By distance
        let distance = UIAlertAction(title: "By distance", style: .default) { [self] (action) -> Void in
            distance_ascend()
            
        }
        //MARK: -- By default
        let _default = UIAlertAction(title: "By default", style: .default) { [self] (action) -> Void in
            defaultSort()
        }
        //MARK: -- Cancel
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
            print("Cancel")
        }
        
        actionSheet.addAction(availableRooms)
        actionSheet.addAction(distance)
        actionSheet.addAction(_default)
        actionSheet.addAction(cancel)
        
        present(actionSheet, animated: true, completion: nil)

    }
}
