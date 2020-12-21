import Foundation
import UIKit

class CustomCell: UITableViewCell {
    static var id: String { String(describing: self )}
    static var nib: UINib { UINib(nibName: id, bundle: nil )}
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var rooms: UILabel!
    @IBOutlet weak var stars: UILabel!
    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        if aDecoder == .none {
//            fatalError("init(coder:) has not been implemented")
//        } else {
//            super.init(coder: aDecoder)
//        }
//    }

    override func awakeFromNib() {
        super.awakeFromNib()
         imageview.layer.cornerRadius = 10
    }

    func set(hotel: Hotel) {
        self.title.text = hotel.name
        address.text = hotel.address
        distance.text = "\(String(describing: Int(hotel.distance)))m from city center"
        rooms.text = "AR: \(hotel.availableRooms)"
        stars.text = String(repeating: "⭑", count: hotel.stars) + String(repeating: "✩", count: 5 - hotel.stars)
        
        imageview.image = hotel.image
    }
}
