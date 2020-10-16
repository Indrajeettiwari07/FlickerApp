// This class is used as extension of UIImageView, This class is used for image caching.
// This can be improved with NSOperations

import Foundation
import UIKit


let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
let imageCache = NSCache<NSString, UIImage>()


//MARK: UIImage View Extension
extension UIImageView {
    
    // Method to be used to load image asynchronusly.
    // - Parameter sender: urlstring from where image needs to be downloaded
    // Result:- Image will be loaded into UIImage view
    
    func downloadImage(_ url: String) {
        // Indicator
        addSubview(activityIndicator)
        activityIndicator.startAnimating()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        
        activityIndicator.color = UIColor.red
        
        ImageDownloadManager.shared.addOperation(url: url, imageView: self) {  [weak self](result,downloadedImageURL)  in
            GCD.runOnMainThread {
                activityIndicator.removeFromSuperview()
                switch result {
                case .Success(let image):
                    self?.image = image
                case .Failure(_):
                    self?.image = ImageConstant.defaultImage
                case .Error(_):
                    self?.image = ImageConstant.defaultImage
                }
            }
        }
    }
}

