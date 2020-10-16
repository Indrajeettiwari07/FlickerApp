//
//  NetworkingTest.swift
//  FlickerAppTests
//
//  Created by Indrajeet Tiwari on 15/10/2020.
//  Copyright © 2020 Indrajeet Tiwari. All rights reserved.
//

import XCTest
@testable import FlickerApp

class NetworkingTest: XCTestCase {
    var networkService: NetworkServiceProtocol?
    
    override func setUpWithError() throws {
        networkService = NetworkService.getFlickerService()
    }

    func testFetchData() {
        let fetchPhotoExpectation = expectation(description: "Data is received Successfully")
        networkService?.fetchData(for: FlickerAPI.photos(searchText: "Amsterdam", pageNo: 1), completion: { photoResult, error in
            fetchPhotoExpectation.fulfill()
            XCTAssertNil(error)
            XCTAssertNotNil(photoResult)
        })
        
         wait(for: [fetchPhotoExpectation], timeout: 3.0)
    }
   
    
    func testFailureScenario() {
        let failedExpectation = expectation(description: "Data is received Successfully")
        networkService?.fetchData(for: FlickerAPI.photos(searchText: "", pageNo: 0), completion: { photoResult, error in
            failedExpectation.fulfill()
           XCTAssertNotNil(error)
        })
        
         wait(for: [failedExpectation], timeout: 3.0)
    }
}
