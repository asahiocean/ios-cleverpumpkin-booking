import Foundation
import UIKit

extension TableViewController {
    override func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let config = UIContextMenuConfiguration(identifier: nil, previewProvider: { [self] () -> UIViewController? in
            
            let bundle = Bundle(for: PreviewHotel.self)
            if let preview = UINib(nibName: PreviewHotel.id, bundle: bundle).instantiate(withOwner: nil, options: nil).first as? PreviewHotel {
                guard let hotel = storage.hotels?[indexPath.row] else { return nil }
                preview.imageView.image = UIImage(data: hotel.imagedata)
                return preview
            }
            return nil
        }) { _ -> UIMenu? in
            let call = UIAction(title: "Позвонить", image: UIImage(systemName: "phone.fill", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))) { action in
                
                if let url = URL(string: "tel://+1-234-567-88-99"), UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
            return UIMenu(title: "", children: [call])
        }
        return config
    }
}
