import UIKit

extension UIImage {
    func makeImageWithColorAndSize(color: UIColor, size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(CGRect(x: 0, y: 10, width: size.width, height: size.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    static func downloadImageFromUrl(_ url: String, completionHandler: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: url) else {
            completionHandler(nil)
            return
        }
        let task: URLSessionDataTask = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> Void in
            guard let httpURLResponse = response as? HTTPURLResponse , httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data , error == nil,
                let image = UIImage(data: data) else {
                    completionHandler(nil)
                    return
            }
            completionHandler(image)
        })
        task.resume()
    }
    
    func scaleToSize(newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
    func imageWithImage(image: UIImage, scaledToSize newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}
