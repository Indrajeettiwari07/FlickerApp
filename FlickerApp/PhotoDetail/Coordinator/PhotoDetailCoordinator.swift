//
//  PhotoDetailCoordinator.swift
// This class is used to coordinate between diffent modules and also it is used to build relations between different entity of VIPER

import UIKit

class PhotoDetailCoordinator: Coordinator {
    
    // MARK: - Properties -
    var navigationController: UINavigationController?
    private var photo: Photo?
    
    // MARK: - Lifecycle -
    init(_ navController: UINavigationController?, photoData: Photo) {
        navigationController = navController
        photo = photoData
    }
    
    
    // MARK: - Builder -
    // The method to be used to make connection between all the entity to be used, relation will be made for presenter->View, Presenter->Interactor, Presenter->Coordinator, Interactor-> Presenter, View->Presenter
    func start() {
        let presenter = PhotoDetailPresenter(photoData: photo)
        guard let viewController = Screen.photoDetail.viewController as? PhotoDetail else {return}
        viewController.presenter = presenter
        
        navigationController?.pushViewController(viewController, animated: true)
    }
}
