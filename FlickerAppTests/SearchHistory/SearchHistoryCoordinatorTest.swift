//
//  SearchHistoryCoordinatorTest.swift
//  FlickerAppTests
//
//  Created by Indrajeet Tiwari on 15/10/2020.
//  Copyright © 2020 Indrajeet Tiwari. All rights reserved.
//

import XCTest
@testable import FlickerApp

class SearchHistoryCoordinatorTest: XCTestCase {
    var coordinator: SearchHistoryCoordinator?
    
    override func setUpWithError() throws {
        guard let app = UIApplication.shared.delegate, let window = app.window else {return}
        guard let searchHistory = Screen.searchHistoy.viewController as? SearchHistoryView else { return }
        let navigationController = UINavigationController(rootViewController: searchHistory )
        window?.rootViewController = navigationController
               
        coordinator = SearchHistoryCoordinator(navigationController: navigationController)
    }
    
    
    func testStart() {
        coordinator?.start()
        XCTAssertNotNil(coordinator?.navigationController)
        XCTAssertEqual(coordinator?.navigationController.viewControllers.count, 1)
    }
}
