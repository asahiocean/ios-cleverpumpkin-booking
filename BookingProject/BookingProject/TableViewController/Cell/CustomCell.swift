import UIKit

class CustomCell: UITableViewCell {

    static var identifier: String { String(describing: self )}
    static var nib: UINib { UINib(nibName: identifier, bundle: nil )}

    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageview.layer.cornerRadius = 10
        
        let activityView = UIActivityIndicatorView(style: .large)
        activityView.center = imageview.center
        activityView.startAnimating()
        imageview.addSubview(activityView)
    }
    
    func qweqwe(size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { context in
            context.fill(CGRect(origin: .zero, size: size))
        }
    }
    
    func set(hotel: Hotel) {
        print(hotel.name)
        
        label.text = hotel.name
        
        let hotelname = hotel.name.replacingOccurrences(of: " ", with: "%20")
        if let url = URL(string: "https://dummyimage.com/400/\(hotel.id)/ffffff&text=\(hotelname)") {
            do {
                let data = try Data(contentsOf: url)
                let image = UIImage(data: data)
                self.imageview.image = image
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override init(style: CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
}
