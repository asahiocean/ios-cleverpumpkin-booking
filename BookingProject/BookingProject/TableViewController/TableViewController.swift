import SwiftUI
import UIKit
import Accelerate

public let updaterQueue = DispatchQueue(label: "updater.queue")
public let updaterGroup = DispatchGroup()

class TableViewController: UITableViewController {
    
    var interactionMap: UIContextMenuInteraction!
    let storage = Storage.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        loadview()
        updaterHotels()
        tableView.register(CustomCell.nib, forCellReuseIdentifier: CustomCell.id)
        tableViewConfig()
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.contentInset = UIEdgeInsets(top: 1, left: 0, bottom: 0, right: 0)
        UIView.animate(withDuration: 0.15, animations: {
            NAVBar.sortButton.alpha = 1
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIView.animate(withDuration: 0.15, animations: {
            NAVBar.sortButton.alpha = 0
        })
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storage.hotels?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.id, for: indexPath) as? CustomCell else { fatalError() }
        if let hotel = storage.hotels?[indexPath.row] { cell.setHotel(hotel) }
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let navcon = navigationController else { return }
        if let hotel = storage.hotels?[indexPath.row] {
            let detailinfo = DetailScreen(hotel: .constant(hotel))
            //let detailinfo = DetailScreen(hotel: hotel)
            let hostVC = UIHostingController(rootView: detailinfo)
            navcon.pushViewController(hostVC, animated: true)
        }
    }
}

extension UIImage {

    func imageByCroppingTransparentPixels() -> UIImage? {
        let rect = cropOpaqueRectForImage()
        guard let cgImage = self.cgImage, let cgImageCrop = cgImage.cropping(to: rect) else {
            return nil
        }
        return UIImage(cgImage: cgImageCrop, scale: self.scale, orientation: self.imageOrientation)
    }
    
    func cropOpaqueRectForImage() -> CGRect {
        guard let cgImage = self.cgImage, let context = createARGBBitmapContext(from: cgImage) else { return .zero }
        
        let width: Int = cgImage.width
        let height: Int = cgImage.height
        let rect = CGRect(x: 0.0, y: 0.0, width: CGFloat(width), height: CGFloat(height))
        context.draw(cgImage, in: rect)
        
        var minX = width
        var maxX = 0
        var minY = height
        var maxY = 0
        
        guard let data = context.data else { return .zero }
        
        let dataType: UnsafeMutablePointer<UInt8> = data.assumingMemoryBound(to: UInt8.self)
        for y in 0..<height {
            for x in 0..<width {
                let pixelIndex = (width * y + x) * 4 /* 4 for A, R, G, B */
                if dataType[pixelIndex] != 0 { // Alpha value is not zero; pixel is not transparent.
                    minX = x < minX ? 0 : x
                    maxX = x > maxX ? 0 : x
                    minY = y < minY ? 0 : y
                    maxY = y > maxY ? 0 : y
                }
            }
        }
        // free(data)
        return CGRect(x: CGFloat(minX), y: CGFloat(minY), width: CGFloat(maxX - minX), height: CGFloat(maxY - minY))
    }

    
    func createARGBBitmapContext(from cgImage: CGImage) -> CGContext? {
        var byteCount = 0
        var bytesPerRow = 0
        
        //Get image width, height
        let w = cgImage.width
        let h = cgImage.height
        
        // Declare the number of bytes per row. Each pixel in the bitmap in this
        // example is represented by 4 bytes; 8 bits each of red, green, blue, and
        // alpha.
        bytesPerRow = w * 4
        byteCount = bytesPerRow * h
        
        // Use the generic RGB color space.
        let colorSpace: CGColorSpace = CGColorSpaceCreateDeviceRGB()
        
        // Allocate memory for image data. This is the destination in memory
        // where any drawing to the bitmap context will be rendered.
        let bitmapData: UnsafeMutableRawPointer = malloc(byteCount)
        let bitmapInfo: CGBitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedFirst.rawValue)
        
        // Create the bitmap context. We want pre-multiplied ARGB, 8-bits
        // per component. Regardless of what the source image format is
        // (CMYK, Grayscale, and so on) it will be converted over to the format
        // specified here by CGBitmapContextCreate.
        guard let context = CGContext(data: bitmapData,
                                width: w,
                                height: h,
                                bitsPerComponent: 8,
                                bytesPerRow: bytesPerRow,
                                space: colorSpace,
                                bitmapInfo: bitmapInfo.rawValue) else { return nil }
        return context
    }
}
