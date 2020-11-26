import Foundation
import UIKit.UITableView

extension TableViewController {
    override func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let config = UIContextMenuConfiguration(identifier: nil, previewProvider: { () -> UIViewController? in
            
            let vc = UINib(nibName: PreviewHotelImage.identifier, bundle: Bundle(for: PreviewHotelImage.self)).instantiate(withOwner: nil, options: nil).first as? PreviewHotelImage
            if let hotel = self.hotels?[indexPath.row] {
                let name = hotel.name.replacingOccurrences(of: " ", with: "%20")
                let url = "https://dummyimage.com/400/\(hotel.id)/ffffff&text=\(name)"
                vc?.setImage(url)
            }
            
            return vc
        }) { _ -> UIMenu? in
            let call = UIAction(title: "Позвонить", image: UIImage(systemName: "phone.fill", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))) { action in
                
                if let url = URL(string: "tel://+1-234-567-88-99"),
                   UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
            return UIMenu(title: "", children: [call])
        }
        return config
    }
}
