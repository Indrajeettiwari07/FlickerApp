// This class is used to coordinate between diffent modules and also it is used to build relations between different entity of VIPER

import UIKit

class SearchHistoryCoordinator: Coordinator {
    
    // MARK: - Properties -
    var navigationController: UINavigationController
    
    
    // MARK: - Lifecycle -
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    
    // MARK: - Builder -
    // The method to be used to make connection between all the entity to be used, relation will be made for presenter->View, Presenter->Interactor, Presenter->Coordinator, Interactor-> Presenter, View->Presenter
    func start() {
        let presenter = SearchHistoryPresenter()
        guard let viewController = Screen.searchHistoy.viewController as? SearchHistoryView else {return}
        viewController.presenter = presenter
        presenter.output = viewController
        
        navigationController.setViewControllers([viewController], animated: false)
    }
}
