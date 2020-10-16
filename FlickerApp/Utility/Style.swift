import UIKit

struct Style {
  
    struct NavigationController {
        static func edit(_ navigationController: UINavigationController) {
            navigationController.navigationBar.tintColor = Colors.black
            navigationController.navigationBar.barTintColor = Colors.white
            navigationController.navigationBar.isTranslucent = true
            navigationController.navigationBar.titleTextAttributes = [
                .foregroundColor: Colors.black,
                .font: Fonts.large
            ]
        }
    }
}

