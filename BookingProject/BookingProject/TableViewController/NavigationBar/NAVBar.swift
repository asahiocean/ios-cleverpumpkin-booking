import Foundation
import UIKit.UIImage

enum NAVBar {
    static var sortIcon: UIImage {
        return UIImage(systemName: "arrow.up.arrow.down", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal) ?? .init()
    }
    static var sortButton: UIButton = {
        let button = UIButton()
        button.tag = 1
        button.setImage(sortIcon, for: .normal)
        button.layer.backgroundColor = #colorLiteral(red: 0.8985465169, green: 0.8972389102, blue: 0.919147253, alpha: 1)
        button.clipsToBounds = true
        DispatchQueue.main.async { button.layer.cornerRadius = button.bounds.width / 2 }
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
}
