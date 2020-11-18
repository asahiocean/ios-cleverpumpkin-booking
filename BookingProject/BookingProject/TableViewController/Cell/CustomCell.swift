import UIKit
import Nuke

class CustomCell: UITableViewCell {

    static var identifier: String { String(describing: self )}
    static var nib: UINib { UINib(nibName: identifier, bundle: nil )}

    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var label: UILabel! {
        didSet {
            
        }
    }
        
    override func awakeFromNib() {
        super.awakeFromNib()
        loadImageIndicator()
        imageview.layer.cornerRadius = 10
    }
        
    func hotel(_ hotel: Hotel) {
        print(hotel.name)
        
        label.text = hotel.name
        
        let _name = hotel.name.replacingOccurrences(of: " ", with: "%20")
        let _url = "https://dummyimage.com/400/\(hotel.id)/ffffff&text=\(_name)"
        API.loadImage(_url, { [self] image -> Void in
            _ = imageview.subviews.map({$0.removeFromSuperview()})
            imageview.image = image
        })
    }
}
extension CustomCell {
    internal func loadImageIndicator() {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        spinner.center = imageview.center
        spinner.startAnimating()
        imageview.addSubview(spinner)
    }
}
