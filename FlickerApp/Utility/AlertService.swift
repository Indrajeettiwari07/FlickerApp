// This class is used to present alert on view

import Foundation
import UIKit

enum alertResponse {
    case OK
    case Cancel
}

protocol AlertService {
    func showAlert(titleStr :String?, messageStr :String?, okButtonTitle :String?, cancelButtonTitle :String?, response :((_ dismissedWithCancel: alertResponse) -> Void)?)
}
extension AlertService where Self: UIViewController{
    
    // generic alert method for creating UIAlertViewController with two buttons.
    //
    // - Parameters:
    //   - controller: controller from where alert will be presented
    //   - titleStr: title of the alert
    //   - messageStr: message of the alert
    //   - okButtonTitle: okay button title
    //   - cancelButtonTitle: cancel button title
    //   - response: closure with enum of the Type alertResponse, if okay button is pressed response will have .OK key. If cancel button is pressed it will have .Cancel key.
    func showAlert(titleStr :String?, messageStr :String?, okButtonTitle :String?, cancelButtonTitle :String?, response :((_ dismissedWithButton: alertResponse) -> Void)?) {
        
        let alertController: UIAlertController = UIAlertController(title: titleStr, message: messageStr, preferredStyle: .alert)
        let ok = UIAlertAction(title: okButtonTitle, style: .default, handler: {(action) in
            alertController.dismiss(animated: true, completion: nil)
            if let okResponse = response {
                okResponse(.OK)
            }
        })
        alertController.addAction(ok)
        if let cancelButtonTitle = cancelButtonTitle {
            let cancel = UIAlertAction(title: cancelButtonTitle, style: .cancel, handler: {(cancel) in
                alertController.dismiss(animated: true, completion: nil)
                if let cancelResponse = response {
                    cancelResponse(.Cancel)
                }
            })
            alertController.addAction(cancel)
        }
        
        GCD.runOnMainThread {
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
}

