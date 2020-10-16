// This method is used to save and retrieve images from cache

import UIKit

class DataCache {

    //static let shared = DataCache()
    
    private(set) static var cache: NSCache<AnyObject, AnyObject> = NSCache()
    
   static func getImageFromCache(key: String) -> UIImage? {
        if (self.cache.object(forKey: key as AnyObject) != nil) {
            return self.cache.object(forKey: key as AnyObject) as? UIImage
        } else {
            return nil
        }
    }
    
   static func saveImageToCache(key: String, image: UIImage) {
        self.cache.setObject(image, forKey: key as AnyObject)
    }
    
}
