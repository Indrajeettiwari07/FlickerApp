//
//  MockSearchCoordinatorTest.swift
//  FlickerAppTests
//
//  Created by Indrajeet Tiwari on 15/10/2020.
//  Copyright © 2020 Indrajeet Tiwari. All rights reserved.
//

import XCTest
@testable import FlickerApp
class MockSearchCoordinatorTest: XCTestCase, SearchCoordinatorInput {

    var showDetail: Bool = false
    
    func showDetail(_ photo: Photo) {
        showDetail = true
    }

}



