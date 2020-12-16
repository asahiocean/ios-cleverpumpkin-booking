import Foundation
import UIKit.UIImage

extension UIImage {
    func crop(w: CGFloat = 0, h: CGFloat = 0) -> UIImage {
        guard let cgImage = self.cgImage?.cropping(to: CGRect(origin: CGPoint(x: w, y: h),
                                                   size: CGSize(width: size.width - 2 * w,
                                                   height: size.height - 2 * h))) else { return .init() }
        return UIImage(cgImage: cgImage)
    }
}
