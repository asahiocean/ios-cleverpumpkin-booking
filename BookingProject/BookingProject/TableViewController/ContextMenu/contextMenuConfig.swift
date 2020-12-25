import Foundation
import UIKit

extension TableViewController {
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
