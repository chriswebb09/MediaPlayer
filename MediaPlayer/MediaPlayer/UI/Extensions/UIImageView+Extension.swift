import UIKit

fileprivate let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    
    func downloadImage(url: URL) {
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            self.image = cachedImage
            return
        }
        URLSession(configuration: .ephemeral).dataTask(with: URLRequest(url: url)) { data, response, error in
            if error != nil {
                print(error?.localizedDescription ?? "Unknown error")
            }
            DispatchQueue.main.async {
                if let data = data, let image = UIImage(data: data) {
                    imageCache.setObject(image, forKey: url.absoluteString as NSString)
                    self.image = image
                }
            }
            }.resume()
    }
}

