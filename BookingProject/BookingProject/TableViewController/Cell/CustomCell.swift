import Foundation
import UIKit

class CustomCell: UITableViewCell {

    static var id: String { String(describing: self )}
    static var nib: UINib { UINib(nibName: id, bundle: nil )}

    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var label: UILabel!
            
    override func awakeFromNib() {
        super.awakeFromNib()
        // loadImageIndicator()
        imageview.layer.cornerRadius = 10
    }
            
    func setHotel(_ hotel: Hotel) {
        label.text = hotel.name
        
        imageview.image = hotel.image
        // _ = imageview.subviews.map({$0.removeFromSuperview()})
    }
}
extension CustomCell {
    internal func loadImageIndicator() {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.hidesWhenStopped = true
        spinner.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        spinner.center = imageview.center
        spinner.color = .systemRed
        spinner.startAnimating()
        imageview.addSubview(spinner)
    }
}
