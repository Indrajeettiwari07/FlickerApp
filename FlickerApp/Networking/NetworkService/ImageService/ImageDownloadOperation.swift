// This class is used to execute operations

import UIKit
import Foundation

typealias ImageCompletion = (_ image : UIImage?, _ url : String) -> Void

class ImageDownloadOperation: Operation {
    
    let url: String?
    var customCompletionBlock: ImageCompletion?
    
    init(url: String, completionBlock: @escaping ImageCompletion) {
        self.url = url
        self.customCompletionBlock = completionBlock
    }
    
    override func main() {
        
        if self.isCancelled { return }
        
        if let url = self.url {
            
            if self.isCancelled { return }
            
            let session = URLSession.shared
            
            guard let url =  URL.init(string: url) else {
                return
            }
            
            // Fetch data from api
            session.dataTask(with: url, completionHandler: { (data, reponse, error) in
                if error != nil {
                    if self.isCancelled { return }
                    return
                }
                
                guard let data = data else {return}
                
                if let image = UIImage(data: data) {
                    if self.isCancelled { return }
                    
                    if let completion = self.customCompletionBlock{
                        completion(image, url.absoluteString)
                    }
                }else {
                    if self.isCancelled { return }
                    return
                }
                
            }).resume()
        }
    }
}

