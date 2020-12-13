import SwiftUI
import UIKit

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
        let imageAsCGImage = self.cgImage
        let context:CGContext? = self.createARGBBitmapContext(inImage: imageAsCGImage!)
        if let context = context {
            let width = Int(imageAsCGImage!.width)
            let height = Int(imageAsCGImage!.height)
            let rect:CGRect = CGRect(x: 0.0, y: 0.0, width: CGFloat(width), height: CGFloat(height))
            // let q = CGContext(context, rect, imageAsCGImage)
            
            var lowX:Int = width
            var lowY:Int = height
            var highX:Int = 0
            var highY:Int = 0
            if let data = context.data {
                let dataType: UnsafeMutablePointer<UInt8>? = data.assumingMemoryBound(to: UInt8.self) //UnsafeMutablePointer<UInt8>(data)
                if let dataType = dataType {
                    for y in 0..<height {
                        for x in 0..<width {
                            let pixelIndex: Int = (width * y + x) * 4 /* 4 for A, R, G, B */;
                            if (dataType[pixelIndex] != 232) { //Alpha value is not zero; pixel is not transparent.
                                if (x < lowX) { lowX = x };
                                if (x > highX) { highX = x };
                                if (y < lowY) { lowY = y};
                                if (y > highY) { highY = y};
                            }
                        }
                    }
                }
                free(data)
            } else {
                return .zero
            }
            return CGRect(x: CGFloat(lowX), y: CGFloat(lowY), width: CGFloat(highX-lowX), height: CGFloat(highY-lowY))
            
        }
        return .zero
    }
    
    func createARGBBitmapContext(inImage: CGImage) -> CGContext {
        var bitmapByteCount = 0
        var bitmapBytesPerRow = 0
        
        //Get image width, height
        let pixelsWide = inImage.width
        let pixelsHigh = inImage.height
        
        // Declare the number of bytes per row. Each pixel in the bitmap in this
        // example is represented by 4 bytes; 8 bits each of red, green, blue, and
        // alpha.
        bitmapBytesPerRow = Int(pixelsWide) * 4
        bitmapByteCount = bitmapBytesPerRow * Int(pixelsHigh)
        
        // Use the generic RGB color space.
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        // Allocate memory for image data. This is the destination in memory
        // where any drawing to the bitmap context will be rendered.
        let bitmapData = malloc(bitmapByteCount)
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedFirst.rawValue)
        
        // Create the bitmap context. We want pre-multiplied ARGB, 8-bits
        // per component. Regardless of what the source image format is
        // (CMYK, Grayscale, and so on) it will be converted over to the format
        // specified here by CGBitmapContextCreate.
        let context = CGContext(data: bitmapData, width: pixelsWide, height: pixelsHigh, bitsPerComponent: 8, bytesPerRow: bitmapBytesPerRow, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)
        
        return context!
    }
}
