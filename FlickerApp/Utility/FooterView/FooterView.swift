// This class is used to create footer view

import Foundation
import UIKit

class FooterView : UICollectionReusableView {
    
    @IBOutlet weak var refreshControlIndicator: UIActivityIndicatorView!
    var isAnimatingFinal:Bool = false
    var currentTransform:CGAffineTransform?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        prepareInitialAnimation()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    
    // Set transform
    func setTransform(inTransform:CGAffineTransform, scaleFactor:CGFloat) {
        if isAnimatingFinal {
            return
        }
        currentTransform = inTransform
        refreshControlIndicator?.transform = CGAffineTransform.init(scaleX: scaleFactor, y: scaleFactor)
    }
    
    
    //reset the animation
    func prepareInitialAnimation() {
        isAnimatingFinal = false
        refreshControlIndicator?.stopAnimating()
        refreshControlIndicator?.transform = CGAffineTransform.init(scaleX: 0.0, y: 0.0)
    }
    
    
    // Start Animation
    func startAnimate() {
        isAnimatingFinal = true
        refreshControlIndicator?.startAnimating()
    }
    
    
    // Stop Animation
    func stopAnimate() {
        isAnimatingFinal = false
        refreshControlIndicator?.stopAnimating()
    }
    
    
    // Final animation to display loading
    func animateFinal() {
        if isAnimatingFinal {
            return
        }
        isAnimatingFinal = true
        UIView.animate(withDuration: 0.2) {
            self.refreshControlIndicator?.transform = CGAffineTransform.identity
        }
    }
}
