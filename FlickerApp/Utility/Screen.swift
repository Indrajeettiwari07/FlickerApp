// This class is used to return view controller

import UIKit

enum Screen {
    case search
    case photoDetail
    case searchHistoy
    
    
    // Below variable is used to return viewcontroller
    var viewController: UIViewController? {
        switch self {
        case .search:
            let storyboard = UIStoryboard(name: Storyboard.search, bundle: nil)
            let search = storyboard.instantiateViewController(withIdentifier: Storyboard.search) as? SearchView
            return search
        case .photoDetail:
            let storyboard = UIStoryboard(name: Storyboard.photoDetail, bundle: nil)
            let photoDetail = storyboard.instantiateViewController(withIdentifier: Storyboard.photoDetail) as? PhotoDetail
            return photoDetail
        case .searchHistoy:
            let storyboard = UIStoryboard(name: Storyboard.searchHistoy, bundle: nil)
            let searchHistoy = storyboard.instantiateViewController(withIdentifier: Storyboard.searchHistoy) as? SearchHistoryView
            return searchHistoy
        }
    }
}
