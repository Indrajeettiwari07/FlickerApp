// This class is used to make GCD operations easy to use

import UIKit

class GCD {
   // To run operation on main thread
    static func runOnMainThread(closure: @escaping () -> Void) {
        DispatchQueue.main.async {
            closure()
        }
    }
    
    
     // To run operation on main thread after some time
    static func runAsynchAfter(delay: Double, closure: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
            closure()
        })
    }
}
