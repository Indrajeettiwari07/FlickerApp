// Identifiers

import Foundation
import UIKit

extension UICollectionViewCell {
    /** View Identifier
     */
    static var identifier: String {
        return String(describing: self)
    }
}


extension UICollectionReusableView {
    static var reusableIdentifier: String {
        return String(describing: self)
    }
}


extension UITableViewCell {
    static var reusableIdentifier: String {
        return String(describing: self)
    }
}
