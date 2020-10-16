//
//  SearchHistoryViewTest.swift
//  FlickerAppTests
//
//  Created by Indrajeet Tiwari on 15/10/2020.
//  Copyright © 2020 Indrajeet Tiwari. All rights reserved.
//

import XCTest
@testable import FlickerApp

class SearchHistoryViewTest: XCTestCase {
    var searchHistoy: SearchHistoryView?
    var searchPresenter: SearchHistoryPresenter?
    
    override func setUpWithError() throws {
        searchHistoy = Screen.searchHistoy.viewController as? SearchHistoryView
        searchPresenter = SearchHistoryPresenter()
        searchHistoy?.presenter = searchPresenter
        searchPresenter?.output = searchHistoy
        searchHistoy?.loadView()
        searchHistoy?.viewDidLoad()
        searchHistoy?.viewWillAppear(true)
        
       // searchPresenter?.getHistory()
    }
    
    func testNumberOfRows(){
        let tableView = searchHistoy?.tableView
        XCTAssertEqual(searchPresenter?.numberOfRowsInSection(),tableView?.dataSource?.tableView(tableView ?? UITableView(), numberOfRowsInSection: 0))
    }
    
    func testNumberOfSection(){
        let tableView = searchHistoy?.tableView
        XCTAssertEqual(searchPresenter?.numberOfSections(),tableView?.dataSource?.numberOfSections?(in: tableView ?? UITableView()))
    }
    
    func testTableViewCell() {
        let indexPath = IndexPath(row: 0, section: 0)
        let tableView = searchHistoy?.tableView
        let cell = tableView?.dataSource?.tableView(tableView ?? UITableView(), cellForRowAt: indexPath)
        let cellReuseIdentifierIdentifer = cell?.reuseIdentifier
        let expectedCellReuseIdentifier = SearchHistoryCell.reusableIdentifier
        XCTAssertEqual(cellReuseIdentifierIdentifer, expectedCellReuseIdentifier)
    }
    
    func testDisplay() {
        searchPresenter?.output?.display()
        let tableView = searchHistoy?.tableView
        XCTAssertEqual(searchPresenter?.numberOfRowsInSection(),tableView?.dataSource?.tableView(tableView ?? UITableView(), numberOfRowsInSection: 0))
    }
    
    func testDisplayError() {
        searchPresenter?.output?.displayError()
        let nav = UINavigationController.init(rootViewController: searchHistoy ?? UIViewController())
        let exp = expectation(description: "Test after 1.5 second wait")
        let result = XCTWaiter.wait(for: [exp], timeout: 1.5)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertNotNil(nav.visibleViewController is UIAlertController)
        } 
    }
    
    func testHeightForRow() {
         let indexPath = IndexPath(row: 0, section: 0)
         let tableView = searchHistoy?.tableView
        XCTAssertEqual(tableView?.delegate?.tableView?(tableView ?? UITableView(), heightForRowAt: indexPath),  searchPresenter?.heightForRow())
    }
    
}
