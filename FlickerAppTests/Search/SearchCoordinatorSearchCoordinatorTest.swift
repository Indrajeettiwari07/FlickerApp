//
//  SearchCoordinatorTest.swift
//  FlickerAppTests
//
//  Created by Indrajeet Tiwari on 15/10/2020.
//  Copyright © 2020 Indrajeet Tiwari. All rights reserved.
//

import XCTest
@testable import FlickerApp
class SearchCoordinatorTest: XCTestCase {
    var coordinator: SearchCoordinator?
    
    override func setUpWithError() throws {
        guard let app = UIApplication.shared.delegate, let window = app.window else {return}
        let search = Screen.search.viewController as? SearchView
        let navigationController = UINavigationController(rootViewController: search ?? UIViewController())
        window?.rootViewController = navigationController
        
        coordinator = SearchCoordinator(navigationController: navigationController)
    }
    
    
    func testStart() {
        coordinator?.start()
        XCTAssertNotNil(coordinator?.navigationController)
        XCTAssertEqual(coordinator?.navigationController.viewControllers.count, 1)
    }
    
    func testShowDetail() {
        let photo = Photo(farm: 1, server: "", secret: "", id: "")
        coordinator?.showDetail(photo)
        let exp = expectation(description: "Test after 1.0 second wait")
        let result = XCTWaiter.wait(for: [exp], timeout: 1.0)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertEqual(coordinator?.navigationController.viewControllers.count, 2)
        }
    }
    
}
