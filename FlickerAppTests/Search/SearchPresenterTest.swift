//
//  SearchPresenterTest.swift
//  FlickerAppTests
//
//  Created by Indrajeet Tiwari on 15/10/2020.
//  Copyright © 2020 Indrajeet Tiwari. All rights reserved.
//

import XCTest
@testable import FlickerApp

class SearchPresenterTest: XCTestCase {
    var presenter: SearchPresenter?
    var interactor = MockSearchInteractor()
    var coordinator = MockSearchCoordinatorTest()
    
    override func setUpWithError() throws {
        presenter = SearchPresenter(interactor: interactor, coordinator: coordinator)
        interactor.output = presenter
        
        presenter?.fetchPhotos(for: "Amsterdam", pageNo: 1)
    }
    
    func testFetchData() {
        presenter!.clearData()
        presenter?.fetchPhotos(for: "Amsterdam", pageNo: 1)
        let exp = expectation(description: "Test after 1.0 second wait")
        let result = XCTWaiter.wait(for: [exp], timeout: 1.0)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertEqual(presenter!.numberOfRowsInSection(), 20)
        }
    }
    
    func testMoreData() {
        presenter!.clearData()
        presenter?.loadMoreData(for: "Amsterdam", pageNo: 1)
        let exp = expectation(description: "Test after 1.0 second wait")
        let result = XCTWaiter.wait(for: [exp], timeout: 1.0)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertEqual(presenter!.numberOfRowsInSection(), 20)
        }
    }
    
    
    // Method to be used to return number of sections
    func testNumberOfSections() {
        XCTAssertEqual(presenter!.numberOfSections(), 1)
    }
    
    
    // Method to be used to return number of rows in section
    func testNumberOfRowsInSection()  {
        XCTAssertEqual(presenter!.numberOfRowsInSection(), 20)
    }
    
    
    // Method to return photo model for row
    func testPhotoURL() {
        let photoURLString = presenter!.photoURL(for: 0)
        XCTAssertEqual("https://farm66.staticflickr.com/65535/50488216471_1b198df714_m.jpg", photoURLString)
        
    }
    
    
    // Method to show details of photo for selected row
    func testShowDetail() {
        presenter!.showDetail(for: 0)
        XCTAssertEqual(coordinator.showDetail, true)
    }
    
    
    func testGetPaging() {
        XCTAssertEqual(presenter!.getPaging(), 1)
    }
    
    
    // Method to get totals
    func testGetTotal()  {
        XCTAssertEqual(presenter!.getTotal(), 368476)
    }
    
    
    // Clear Data
    func testClearData() {
        presenter!.clearData()
        XCTAssertEqual(presenter!.numberOfRowsInSection(), 0)
        XCTAssertEqual(presenter!.isLoading, false)
    }
    
    
    // Failure Scenario
    func testFailureScenario() {
        presenter!.clearData()
        presenter!.fetchPhotos(for: "", pageNo: 1)
        XCTAssertEqual(presenter!.numberOfRowsInSection(), 0)
        
        presenter!.fetchPhotos(for: "AMS", pageNo: 0)
        XCTAssertEqual(presenter!.numberOfRowsInSection(), 0)
    }
 
}
