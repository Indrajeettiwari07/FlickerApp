//
//  SearchInteractorTest.swift
//  FlickerAppTests
//
//  Created by Indrajeet Tiwari on 15/10/2020.
//  Copyright © 2020 Indrajeet Tiwari. All rights reserved.
//

import XCTest
@testable import FlickerApp

class SearchInteractorTest: XCTestCase {
    var interactor: SearchInteractor?
    var output = MockSearchPresenter()
    
    override func setUpWithError() throws {
        interactor = SearchInteractor()
        interactor?.output = output
    }
    
    
    func testGetPhoto() {
        interactor!.getPhoto(for: "Amsterdam", pageNo: 1)
        
        let exp = expectation(description: "Test after 1.0 second wait")
        let result = XCTWaiter.wait(for: [exp], timeout: 1.0)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertEqual(output.dataReceived, true)
        }
    }
    
    
    func testFailerScenario() {
        interactor!.getPhoto(for: "", pageNo: 0)
        
        let exp = expectation(description: "Test after 1.0 second wait")
        let result = XCTWaiter.wait(for: [exp], timeout: 1.0)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertEqual(output.errorExist, true)
        }
    }
}
