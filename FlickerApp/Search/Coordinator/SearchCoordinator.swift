// This class is used to coordinate between diffent modules and also it is used to build relations between different entity of VIPER

import UIKit

class SearchCoordinator: Coordinator {
    
    // MARK: - Properties -
    var navigationController: UINavigationController
    
    
    // MARK: - Lifecycle -
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    
    // MARK: - Builder -
    // The method to be used to make connection between all the entity to be used, relation will be made for presenter->View, Presenter->Interactor, Presenter->Coordinator, Interactor-> Presenter, View->Presenter
    func start() {
        let interactor = SearchInteractor()
        let presenter = SearchPresenter(interactor: interactor, coordinator: self)
        guard let viewController = Screen.search.viewController as? SearchView else {return}
        viewController.presenter = presenter
        interactor.output = presenter
        presenter.output = viewController
        
        navigationController.setViewControllers([viewController], animated: false)
    }
}


// PRESENTER -> COORDINATOR
extension SearchCoordinator: SearchCoordinatorInput {
    
    // - Methods to show details of selected row
    // - Parameter sender: index(row selected)
    func showDetail(_ photo: Photo) {
        let coordinator = PhotoDetailCoordinator(navigationController, photoData: photo)
        coordinator.start()
    }
}
