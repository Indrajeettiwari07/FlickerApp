// This class is used to execute user events
// This class is used to interact with interactor and receive response through protocols
// This class is used to request coordinator to move to next screen.

import Foundation

class SearchPresenter {
    
    // MARK: - Properties -
    let interactor: SearchInteractorInput
    var coordinator: SearchCoordinatorInput?
    weak var output: SearchPresenterOutput?
    var isLoading: Bool {
        return loadMore
    }
    
    // MARK: - Private Properties -
    private var photoList = [Photo]()
    private  var photos: Photos?
    private var total:String?
    private var loadMore:Bool = false
    private var searchHistory:[String]?
    private var dataManager: DataManager
    
    
    // MARK: - Lifecycle -
    init(interactor: SearchInteractorInput, coordinator: SearchCoordinatorInput)  {
        self.interactor = interactor
        self.coordinator = coordinator
        dataManager = DataManager()
        setDataForSearchHistory()
    }
}


// View -> Presenter
// Method to receive user events
// MARK: User Events
extension SearchPresenter: SearchPresenterInput {
    
    // Method to be used to fetch photos from api
    func fetchPhotos(for searchedText: String, pageNo: Int) {
        guard Reachability.isConnectedToNetwork() else {
            output?.displayError(error: NetworkError.internetError)
            return
        }
        
        save(searchText: searchedText)
        loadMore = true
        loadData(for: searchedText, pageNo: pageNo)
    }
    
    // Fetch data from api
    private func loadData(for searchedText: String, pageNo: Int) {
        interactor.getPhoto(for: searchedText, pageNo: pageNo)
    }
    
    // Method to load more data
    func loadMoreData(for searchedText: String, pageNo: Int) {
        loadMore = true
        loadData(for: searchedText, pageNo: pageNo)
    }
    
    
    // Method to be used to return number of sections
    func numberOfSections() -> Int {
        return Defaults.forSection
    }
    
    
    // Method to be used to return number of rows in section
    func numberOfRowsInSection() -> Int {
        return photoList.count
    }
    
    
    // Method to return photo url for row
    func photoURL(for row: Int) -> String? {
        let photo = photoList[row]
        let flickerImage = FlickerAPI.flickerImage(photo: photo, size: ImageSize.thumbnail)
        return flickerImage.baseURL.absoluteString + flickerImage.path
    }
    
    
    // Method to show details of photo for selected row
    func showDetail(for indexPath: Int) {
        guard let photo = photoList[safe: indexPath] else {return}
        coordinator?.showDetail(photo)
    }
    
    func getPaging() -> Int {
        return photos?.page ?? 0
    }
    
    
    // Method to get totals
    func getTotal() -> Int {
        return Int(photos?.total ?? "") ?? 0
    }
    
    
    // Clear Data
    func clearData() {
        photoList.removeAll()
        photos?.page = 0
        loadMore = false
    }
    
}


extension SearchPresenter {
    
    // Get the Stored history list form the disk and assign it to searchHistory, if there is no list allocate searchHistory
    private func setDataForSearchHistory() {
        guard let historyData = dataManager.getData(for: FileName.forHistory, to: [String].self) else {
            searchHistory = [String]()
            return
        }
        
        searchHistory = historyData
    }
    
    
    // Save the searched text into disk
    private func save(searchText:String) {
        searchHistory?.append(searchText)
        dataManager.storeData(data: searchHistory, for: FileName.forHistory)
    }
}


// Interactor -> Presenter
// Method to receive network result
// MARK: Interacto Output
extension SearchPresenter: SearchInteractorOutput {
    
    // Method to receive search result from api
    func present(_ searchResult: PhotoResult) {
        photos = searchResult.photos
        
        guard photos?.photo.count ?? 0 > 0 else {
            output?.displayError(error: NetworkError.noDataFouned)
            return
        }
        
        loadMore = false
        photoList.append(contentsOf: photos?.photo ?? [])
        output?.display()
    }
    
    
    // Method to receive error from api
    func presentError(error: NetworkError) {
        loadMore = false
        output?.displayError(error: error)
    }
}
