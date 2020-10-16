//
//  SearchViewTest.swift
//  FlickerAppTests
//
//  Created by Indrajeet Tiwari on 15/10/2020.
//  Copyright © 2020 Indrajeet Tiwari. All rights reserved.
//

import XCTest
@testable import FlickerApp

class SearchViewTest: XCTestCase {
    var searchView: SearchView?
    var presenter: SearchPresenter?
    var interactor = MockSearchInteractor()
    var coordinator = MockSearchCoordinatorTest()
    
    override func setUpWithError() throws {
        searchView = Screen.search.viewController as? SearchView
        presenter = SearchPresenter(interactor: interactor, coordinator: coordinator)
        searchView?.presenter = presenter
        presenter?.output = searchView
        
        searchView?.loadView()
        searchView?.viewDidLoad()
        
        presenter?.fetchPhotos(for: "Amsterdam", pageNo: 1)
        
    }
    
    
    func testCanInstantiateViewController() {
        XCTAssertNotNil(searchView)
    }
    
    func testCollectionViewIsNotNilAfterViewDidLoad() {
        XCTAssertNotNil(searchView?.collectionView)
    }
    
    func testHasItemsForCollectionView() {
        XCTAssertNotNil(presenter?.numberOfRowsInSection)
    }
    
    func testNumberOfSection() {
        XCTAssertNotNil(presenter?.numberOfSections)
    }
    
    func testShouldSetCollectionViewDelegate() {
        XCTAssertNotNil(searchView?.collectionView.delegate)
    }
    
    func test_CellData(){
        let indexPath = IndexPath(row: 0, section: 0)
        guard let collectionView = searchView?.collectionView else { return  }
        let cell = searchView?.collectionView?.dataSource?.collectionView(collectionView, cellForItemAt: indexPath)
        let cellReuseIdentifierIdentifer = cell?.reuseIdentifier
        let expectedCellReuseIdentifier = FlickrPhotoCell.identifier
        XCTAssertEqual(cellReuseIdentifierIdentifer, expectedCellReuseIdentifier)
    }
    
  
    
    func testDisplay() {
         presenter?.fetchPhotos(for: "Amsterdam", pageNo: 1)
        let collectionView = searchView?.collectionView
        XCTAssertEqual(presenter?.numberOfRowsInSection(),collectionView?.dataSource?.collectionView(collectionView ?? UICollectionView(), numberOfItemsInSection: 0))
    }
    
    func testDisplayError() {
        presenter?.output?.displayError(error: .requestError)
        let nav = UINavigationController.init(rootViewController: searchView ?? UIViewController())
        let exp = expectation(description: "Test after 1.5 second wait")
        let result = XCTWaiter.wait(for: [exp], timeout: 1.5)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertNotNil(nav.visibleViewController is UIAlertController)
        }
    }
    
  
    
    func testCustomViewContainsAView() {
        let bundle = Bundle(for: FooterView.self)
        
        guard let footerView = bundle.loadNibNamed("FooterView", owner: nil)?.first as? FooterView else {
            return XCTFail("CustomView nib did not contain a UIView")
        }
        
        footerView.layoutSubviews()
        
        footerView.setTransform(inTransform: CGAffineTransform.identity, scaleFactor: CGFloat(1.0))
        XCTAssertEqual(footerView.refreshControlIndicator.transform, CGAffineTransform.init(scaleX: CGFloat(1.0), y: CGFloat(1.0)))
        
        XCTAssertEqual(footerView.reuseIdentifier, footerView.reuseIdentifier)
        
        footerView.startAnimate()
        XCTAssertEqual(footerView.refreshControlIndicator.isAnimating, true)
        
        footerView.prepareInitialAnimation()
        XCTAssertEqual(footerView.isAnimatingFinal, false)
        XCTAssertEqual(footerView.refreshControlIndicator.isAnimating, false)
        
        footerView.stopAnimate()
        XCTAssertEqual(footerView.refreshControlIndicator.isAnimating, false)
        
         footerView.animateFinal()
        XCTAssertEqual(footerView.isAnimatingFinal, true)
    }
    
}
