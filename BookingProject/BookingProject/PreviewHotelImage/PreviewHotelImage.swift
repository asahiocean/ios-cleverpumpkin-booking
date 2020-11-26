import UIKit

class PreviewHotelImage: UIViewController {
    
    static var identifier: String { String(describing: self )}
    static var nib: UINib { UINib(nibName: identifier, bundle: nil )}
    let imageView: UIImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let _w = view.bounds.width * 0.9
        imageView.frame.size = CGSize(width: _w, height: _w)
        imageView.center.x = view.center.x
        imageView.frame.origin.y = view.frame.height / 8
        
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.black.cgColor

        imageView.contentMode = .scaleAspectFit
        
        view.addSubview(imageView)
    }
}
