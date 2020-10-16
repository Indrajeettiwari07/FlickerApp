//
//  SearchHistoryPresenterTest.swift
//  FlickerAppTests
//
//  Created by Indrajeet Tiwari on 15/10/2020.
//  Copyright © 2020 Indrajeet Tiwari. All rights reserved.
//

import XCTest
@testable import FlickerApp

class SearchHistoryPresenterTest: XCTestCase {
    var searchHistoryPresenter: SearchHistoryPresenter?
    var dataManager: DataManager?
    var historyData: [String]?
    let rowHeight: CGFloat = 44.0
    
    override func setUpWithError() throws {
        searchHistoryPresenter = SearchHistoryPresenter()
        dataManager = DataManager()
        historyData = dataManager?.getData(for: "History", to: [String].self)?.reversed()
        searchHistoryPresenter?.getHistory()
    }
    
    
    func testGetHistory() {
        searchHistoryPresenter?.getHistory()
        let numberOfRows: Int = searchHistoryPresenter!.numberOfRowsInSection()
        if historyData != nil {
            XCTAssertEqual(numberOfRows, historyData?.count)
        }
        
        
    }
    
    
    func testNumberOfRowsInSection() {
        if historyData != nil {
            XCTAssertEqual(searchHistoryPresenter?.numberOfRowsInSection(), historyData?.count)
        }
        
    }
    
    func testNumberOfSections()  {
        XCTAssertEqual(searchHistoryPresenter?.numberOfSections(), 1)
    }
    
    func testSearchedText() {
        if historyData != nil {
            XCTAssertEqual(searchHistoryPresenter?.searchedText(for: 0), historyData?[0])
        }
    }
    
    func testHeightForRow() {
        XCTAssertEqual(searchHistoryPresenter?.heightForRow(), rowHeight)
    }
    
    func testFailureScenario() {
        historyData = dataManager?.getData(for: "", to: [String].self)?.reversed()
        searchHistoryPresenter?.getHistory()
        XCTAssertNil(historyData?.count)
    }
}
