import UIKit

class PreviewHotelImage: UIViewController {
    
    static var identifier: String { String(describing: self )}
    static var nib: UINib { UINib(nibName: identifier, bundle: nil )}
    
    func setImage(_ urlString: String) {
        guard let url = URL(string: urlString) else { return }
//        API.loadImage(url, { [self] _image -> Void in
//            guard let image = _image else { removeFromParent(); return }
//
//            let imageView = UIImageView(image: image)
//            imageView.contentMode = .scaleAspectFill
//
//            let _w = view.bounds.width * 0.9
//            imageView.frame.size = CGSize(width: _w, height: _w)
//            imageView.center.x = view.center.x
//            imageView.frame.origin.y = view.frame.height / 8
//            
//            imageView.clipsToBounds = true
//            imageView.layer.cornerRadius = 10
//            
//            imageView.layer.borderWidth = 3
//            imageView.layer.borderColor = UIColor.black.cgColor
//            
//            let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
//            blurView.frame = view.bounds
//            blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//            blurView.backgroundColor = UIColor(patternImage: image)
//            view.addSubview(blurView)
//
//            view.addSubview(imageView)
//        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
