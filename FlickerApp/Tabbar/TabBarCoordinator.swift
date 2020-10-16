// This class is used to create tabbar
import UIKit

final class TabBarCoordinator: Coordinator {
    
    // MARK: - Properties -
    var children: [Coordinator]
    
    private let window: UIWindow
    private let tabBarController: UITabBarController
    
    // Enum used for different tab bar screen
    private enum Tab {
        case Search, SearchHistory
    }
    
    // MARK: - Lifecycle -
    init(window: UIWindow) {
        self.window = window
        tabBarController = UITabBarController()
        children = []
        
        setupTabBar()
    }
    
    // MARK: - Methods -
    func start() {
        addScene(with: .Search)
        addScene(with: .SearchHistory)
        window.updateRootViewController(with: tabBarController)
    }
    
    
    // Configure tabbar
    func setupTabBar() {
        tabBarController.tabBar.barTintColor = Colors.black
        tabBarController.tabBar.tintColor = Colors.white
    }
    
    // Add scene on tabbar
    private func addScene(with tab: Tab) {
        let navigationController = UINavigationController()
        // navigationController.setNavigationBarHidden(true, animated: false)
        Style.NavigationController.edit(navigationController)
        
        var viewControllers = tabBarController.viewControllers ?? []
        viewControllers += [navigationController]
        tabBarController.setViewControllers(viewControllers, animated: true)
        
        let coordinator: Coordinator
        
        switch tab {
        case .Search:
            coordinator = SearchCoordinator(navigationController: navigationController)
            navigationController.tabBarItem = UITabBarItem(title: Translation.Search.title, image: Icons.search, selectedImage: nil)
        case .SearchHistory:
            coordinator = SearchHistoryCoordinator(navigationController: navigationController)
            navigationController.tabBarItem = UITabBarItem(title: Translation.SearchHistory.title, image: Icons.searchHistory, selectedImage: nil)
        }
        
        children.append(coordinator)
        coordinator.start()
    }
}

