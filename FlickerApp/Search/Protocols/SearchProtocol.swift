
import Foundation

// ======== Coordinator ======== //
// PRESENTER -> COORDINATOR
protocol SearchCoordinatorInput: class {
    func showDetail(_ photo: Photo) 
}


// ======== Interactor ======== //
// PRESENTER -> INTERACTOR
protocol SearchInteractorInput {
    // MARK: - Fetch Result For Searched Text
    func getPhoto(for searchedText: String,  pageNo: Int)
}


// INTERACTOR -> PRESENTER
protocol SearchInteractorOutput: class {
    // MARK: - Search  Result -
    func present(_ searchResult: PhotoResult)
    func presentError(error: NetworkError)
}


// ======== Presenter ======== //
// VIEW -> PRESENTER
protocol SearchPresenterInput {
    var isLoading: Bool {get}
    func fetchPhotos(for searchedText: String, pageNo: Int)
    func numberOfRowsInSection() -> Int
    func photoURL(for row: Int) -> String?
    func showDetail(for indexPath: Int)
    func numberOfSections() -> Int
    func getPaging() -> Int
    func getTotal() -> Int
    func clearData()
    func loadMoreData(for searchedText: String, pageNo: Int)
}


// PRESENTER -> VIEW
protocol SearchPresenterOutput: class {
    func display()
    func displayError(error: NetworkError)
}


//Search Cell Protocol
protocol SearchCellInput {
    associatedtype dataType
    func configure(with data: dataType?)
}


