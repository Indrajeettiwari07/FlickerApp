//
//  MockSearchInteractor.swift
//  FlickerAppTests
//
//  Created by Indrajeet Tiwari on 15/10/2020.
//  Copyright © 2020 Indrajeet Tiwari. All rights reserved.
//

import XCTest
@testable import FlickerApp


class MockSearchInteractor: SearchInteractorInput {
    // MARK: - Properties -
    weak var output: SearchInteractorOutput?
    var networkService: NetworkServiceProtocol?
    
    func getPhoto(for searchedText: String, pageNo: Int) {
         networkService = NetworkService.getMockService()
        
        // This is to test negative scenario
        guard searchedText != "" else { output?.presentError(error: NetworkError.requestError); return}
        
        guard pageNo != 0 else {output?.present(PhotoResult(stat: "Ok", photos: Photos(page: 0, pages: 0, perpage: 0, total: "0", photo: [])))
            return
        }
        
        networkService?.fetchData(for: FlickerAPI.photos(searchText: "", pageNo: 1), completion: { [weak self] photoResult, error in
            guard error == nil else {
                self?.output?.presentError(error: NetworkError.requestError)
                return
            }
            
            guard let photoResult = photoResult else {
                self?.output?.presentError(error: NetworkError.requestError)
                return
            }
            
            self?.output?.present(photoResult)
        })
    }
    
  }
