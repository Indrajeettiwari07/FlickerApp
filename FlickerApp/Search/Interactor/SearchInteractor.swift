// This class is used to interact with Network layer and fetch data.

import Foundation

class SearchInteractor {
    // MARK: - Properties -
    weak var output: SearchInteractorOutput?
    var networkService: NetworkServiceProtocol
    
    // MARK: - Life Cycle
    init() {
        networkService = NetworkService.getFlickerService()
    }
}

// Presenter -> Interactor
// Class to be used to interact with network layer and fetch result
// MARK: - Business Logic -
extension SearchInteractor: SearchInteractorInput {
    
    // Method to capture list of photos for searched text
    // - Parameter sender: searched text and pageNo.
    //- Result :  List of photos is sent to presenter if received , else error is sent to presenter
    func getPhoto(for searchedText: String,  pageNo: Int) {
        
        networkService.fetchData(for: FlickerAPI.photos(searchText:searchedText,pageNo: pageNo), completion: { [weak self] photoResult, error in
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
