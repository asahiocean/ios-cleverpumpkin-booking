import Foundation
import UIKit

class CustomCell: UITableViewCell {

    static var id: String { String(describing: self )}
    static var nib: UINib { UINib(nibName: id, bundle: nil )}

    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var label: UILabel!
            
    override func awakeFromNib() {
        super.awakeFromNib()
        loadImageIndicator()
        imageview.layer.cornerRadius = 10
    }
            
    func set(hotel: Hotel) {
        label.text = hotel.name
        
        guard hotel.image.pngData() != nil else { return }
        _ = imageview.subviews.map({ $0.removeFromSuperview() })
        imageview.image = hotel.image
    }
}
extension CustomCell {
    internal func loadImageIndicator() {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.hidesWhenStopped = true
        spinner.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        spinner.center = imageview.center
        spinner.color = .systemRed
        spinner.startAnimating()
        imageview.addSubview(spinner)
    }
}

//         print("Cell image size:", String(describing: hotel.image.pngData()?.count))
