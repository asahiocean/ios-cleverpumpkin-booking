import UIKit
import Nuke

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
        _ = imageview.subviews.map({$0.removeFromSuperview()})
        imageview.image = hotel.image
        label.text = hotel.name
        print("Cell image size:", String(describing: hotel.image.pngData()?.count))
    }
}
extension CustomCell {
    internal func loadImageIndicator() {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.hidesWhenStopped = true
        spinner.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        spinner.center = imageview.center
        spinner.startAnimating()
        imageview.addSubview(spinner)
    }
}
