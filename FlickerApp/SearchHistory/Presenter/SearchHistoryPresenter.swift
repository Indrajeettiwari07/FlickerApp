// This class is used to execute user events
// This class is used to interact with interactor and receive response through protocols
// This class is used to request coordinator to move to next screen.

import UIKit

class SearchHistoryPresenter {
    
    // MARK: - Properties -
    private var searchHistory: [String]?
    private var dataManager: DataManager
    weak var output: SearchHistoryPresenterOutput?
    
    
    // MARK: - Lifecycle -
    init() {
        dataManager = DataManager()
    }
}


// MARK: User Events
extension SearchHistoryPresenter: SearchHistoryPresenterInput {
    
    // Method to fetch search history from disk
    func getHistory() {
        getDataFromDisk()
    }
    
    
    // To return number of rows for tableview
    func numberOfRowsInSection() -> Int {
        return searchHistory?.count ?? 0
    }
    
    
    // To return number of sections for tableview
    func numberOfSections() -> Int {
        return Defaults.forSection
    }
    
    
    // Method to be used to receive searched text for row
    func searchedText(for row: Int) -> String {
        return searchHistory?[row] ?? ""
    }
    
    
    // To return height for row
    func heightForRow() -> CGFloat {
        return Defaults.forRowHeight
    }
    
    
    // Method to be used to fetch data from the disc
    private func getDataFromDisk() {
        guard let historyData = dataManager.getData(for: "History", to: [String].self) else {
            output?.displayError()
            return
        }
        
        searchHistory = historyData.reversed()
        output?.display()
    }
}

