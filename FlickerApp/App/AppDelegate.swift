
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var coordinator: AppCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Start APP Flow here
        coordinator = AppCoordinator(window: UIWindow(frame: UIScreen.main.bounds))
        coordinator?.start()
        
        return true
    }
}

