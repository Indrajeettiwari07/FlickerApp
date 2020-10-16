//
//  PhotoDetailPresenter.swift
//  FlickerAppTests
//
//  Created by Indrajeet Tiwari on 15/10/2020.
//  Copyright © 2020 Indrajeet Tiwari. All rights reserved.
//

import XCTest
@testable import FlickerApp

class PhotoDetailPresenterTest: XCTestCase {
    var presenter: PhotoDetailPresenter?
    
    override func setUpWithError() throws {
        let photo =  Photo(farm: 66, server: "65535", secret: "32765675e7", id: "50488323372")
        presenter = PhotoDetailPresenter(photoData: photo)
   }
    
    
    func testPhotoUrlString() {
        let photoURLString = presenter?.getPhotoUrl()
        XCTAssertEqual(photoURLString, "https://farm66.staticflickr.com/65535/50488323372_32765675e7_b.jpg")
    }
}
