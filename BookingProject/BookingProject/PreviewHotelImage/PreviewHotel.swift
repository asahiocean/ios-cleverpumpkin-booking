import UIKit

class PreviewHotel: UIViewController {
    
    static var id: String { String(describing: self )}
    @IBOutlet weak var imageView: UIImageView!
    
    public func setImage(_ image: UIImage) {
        imageView.image = image
        preferredContentSize = image.size
    }
}
