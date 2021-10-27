import UIKit

public extension String {
    /// Restituisce un'istanza di SPCScene.Image da una stringa. Si usa per generare un'immagine basata su una stringa emoji.
    func image() -> Image {
        let size = CGSize(width: 80, height: 80)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        UIColor.clear.set()
        let rect = CGRect(origin: .zero, size: size)
        UIRectFill(CGRect(origin: .zero, size: size))
        (self as AnyObject).draw(in: rect, withAttributes: [.font: UIFont.systemFont(ofSize: 70)])
        if let image = UIGraphicsGetImageFromCurrentImageContext() {
            UIGraphicsEndImageContext()
            return Image(with: image)
            
        } else {
            return Image(with: UIImage())
        }
    }
}
