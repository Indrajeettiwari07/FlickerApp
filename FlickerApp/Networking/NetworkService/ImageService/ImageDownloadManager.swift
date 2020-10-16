// This Class is used to download images with operations in queue

import UIKit

typealias ImageClosure = (_ result: Result<UIImage>, _ url: String) -> Void

class ImageDownloadManager {
    
    // MARK: - Properties -
    static let shared = ImageDownloadManager()
    private var operationQueue = OperationQueue()
    private var dictionaryBlocks = [UIImageView: (String, ImageClosure, ImageDownloadOperation)]()
    
    
    //MARK: LifeCycle
    private init() {
        operationQueue.maxConcurrentOperationCount = 1
    }
    
    
    // Method to put image download in operation queue
    func addOperation(url: String, imageView: UIImageView, completion: @escaping ImageClosure) {
        
        if let image = DataCache.getImageFromCache(key: url)  {
            if let tupple = self.dictionaryBlocks.removeValue(forKey: imageView){
                tupple.2.cancel()
            }
            completion(.Success(image), url)
            
        } else {
            
            if !checkOperationExists(with: url,completion: completion) {
                
                if let tupple = self.dictionaryBlocks.removeValue(forKey: imageView){
                    tupple.2.cancel()
                }
                
                let newOperation = ImageDownloadOperation(url: url) { (image,downloadedImageURL) in
                    
                    if let tupple = self.dictionaryBlocks[imageView] {
                        
                        if tupple.0 == downloadedImageURL {
                            
                            if let image = image {
                                
                                DataCache.saveImageToCache(key: downloadedImageURL, image: image)
                                tupple.1(.Success(image), downloadedImageURL)
                                
                                if let tupple = self.dictionaryBlocks.removeValue(forKey: imageView){
                                    tupple.2.cancel()
                                }
                                
                            } else {
                                tupple.1(.Failure("Not fetched"), downloadedImageURL)
                            }
                            
                            _ = self.dictionaryBlocks.removeValue(forKey: imageView)
                        }
                    }
                }
                
                dictionaryBlocks[imageView] = (url, completion, newOperation)
                operationQueue.addOperation(newOperation)
            }
        }
    }
    
    
    // Method to check if operation is still in progress
    func checkOperationExists(with url: String, completion: @escaping ImageClosure) -> Bool {
        
        if let arrayOperation = operationQueue.operations as? [ImageDownloadOperation] {
            let opeartions = arrayOperation.filter{$0.url == url}
            return opeartions.count > 0 ? true : false
        }
        
        return false
    }
}
