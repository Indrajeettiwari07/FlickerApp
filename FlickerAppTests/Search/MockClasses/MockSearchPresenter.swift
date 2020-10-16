//
//  MockSearchPresenter.swift
//  FlickerAppTests
//
//  Created by Indrajeet Tiwari on 15/10/2020.
//  Copyright © 2020 Indrajeet Tiwari. All rights reserved.
//

import XCTest
@testable import FlickerApp

class MockSearchPresenter: SearchInteractorOutput {
    
    var dataReceived: Bool = false
    var errorExist: Bool = false
    
    func present(_ searchResult: PhotoResult) {
        dataReceived = true
    }
    
    func presentError(error: NetworkError) {
        errorExist = true
    }
    
}


