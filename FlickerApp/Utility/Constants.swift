// This class is used for constant

import Foundation
import UIKit


// Storyboard identifier
struct Storyboard {
    static let search = "Search"
    static let photoDetail = "PhotoDetail"
    static let searchHistoy = "SearchHistory"
}

struct NibName {
    static let forFooter = "FooterView"
}

// File Names
struct FileName {
    static let forHistory = "History"
    static let forMockData = "Photo"
}


// Scroll View Constant
struct ScrollViewContstant {
    static let maximumZoomScale: CGFloat = 5.0
    static let minimumZoomScale: CGFloat = 1.0
}

// Image Constant
struct ImageConstant {
    static let defaultImage = UIImage(named: "DefaultImage")
}

struct SearchedItem {
    static let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    static let itemsPerRow: CGFloat = 2
}


// Image Size
struct ImageSize {
    static let thumbnail = "m"
    static let large = "b"
}


struct Defaults {
    static let forSection = 1
    static let forRowHeight: CGFloat = 44.0
    static let emptySearchText = 0
}
