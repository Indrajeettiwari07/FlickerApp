//
//  PhotoDetailCoordinatorTest.swift
//  FlickerAppTests
//
//  Created by Indrajeet Tiwari on 15/10/2020.
//  Copyright © 2020 Indrajeet Tiwari. All rights reserved.
//

import XCTest
@testable import FlickerApp

class PhotoDetailCoordinatorTest: XCTestCase {
    var coordinator: PhotoDetailCoordinator?
    
    override func setUpWithError() throws {
        let photo =  Photo(farm: 66, server: "65535", secret: "32765675e7", id: "50488323372")
        
        guard let app = UIApplication.shared.delegate, let window = app.window else {return}
        let search = Screen.photoDetail.viewController as? SearchView
        let navigationController = UINavigationController(rootViewController: search ?? UIViewController())
        window?.rootViewController = navigationController
        
        coordinator = PhotoDetailCoordinator(navigationController, photoData: photo)
    }
    
    
    func testStart() {
        coordinator?.start()
        XCTAssertNotNil(coordinator?.navigationController)
        XCTAssertEqual(coordinator?.navigationController?.viewControllers.count, 1)
    }
}
