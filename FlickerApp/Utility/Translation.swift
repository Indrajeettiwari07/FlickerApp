import Foundation

struct Translation {
   struct Search {
        static let title = NSLocalizedString("Search", comment: "")
        static let noResult = NSLocalizedString("Your search returned no results", comment: "")
    }
    
    struct PhotoDetail {
        static let title = NSLocalizedString("Photo", comment: "")
    }
    
    struct SearchHistory {
           static let title = NSLocalizedString("SearchHistory", comment: "")
       }
    
    // String Constant
    struct StringConstant {
        static let error =  NSLocalizedString("Error", comment: "")
        static let ok = NSLocalizedString("Ok", comment: "")
    }
    
    // Network Error
    struct NetworkCosntant {
        static let errorMessage = NSLocalizedString("errorMsg", comment: "")
        static let noInternetError =  NSLocalizedString("noInternet", comment: "") 
    }
}


