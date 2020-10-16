//
//  PhotoDetailTest.swift
//  FlickerAppTests
//
//  Created by Indrajeet Tiwari on 15/10/2020.
//  Copyright © 2020 Indrajeet Tiwari. All rights reserved.
//

import XCTest
@testable import FlickerApp

class PhotoDetailTest: XCTestCase {
    var photoDetail: PhotoDetail?
    var presenter: PhotoDetailPresenter?
    
    override func setUpWithError() throws {
        photoDetail = Screen.photoDetail.viewController as? PhotoDetail
        
        let photo =  Photo(farm: 66, server: "65535", secret: "32765675e7", id: "50488323372")
        presenter = PhotoDetailPresenter(photoData: photo)
        photoDetail?.presenter = presenter
        photoDetail?.loadView()
        photoDetail?.viewDidLoad()
        
       
    }
    
    func testImage() {
        let exp = expectation(description: "Test after 1.0 second wait")
        let result = XCTWaiter.wait(for: [exp], timeout: 1.0)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertNotNil(photoDetail?.imageView.image)
        }
    }
    
    
}
