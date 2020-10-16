/// This class is used to receive user events and pass it to presenter
/// This class is used to creat UI and adjust it.

import UIKit
class SearchView: UICollectionViewController {
    
    // MARK: - Properties -
    var presenter: SearchPresenterInput?
    var searchController = UISearchController(searchResultsController: nil)
    var footerView: FooterView?
}


//MARK: LifeCycle
extension SearchView {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Registration for footerview
        collectionView?.register(UINib(nibName: NibName.forFooter, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: FooterView.reusableIdentifier)
        
        // Configure Search
        configureSearch()
        
        // Set title
        self.title = Translation.Search.title
    }
    
    
    // Configure Search View Controller
    private func configureSearch() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "search here"
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        self.definesPresentationContext = true
    }
    
    
    // MARK: - Helper Method
    @objc func loadMorePhotos() {
        guard let searchText = searchController.searchBar.text, searchText.count > 0 else {
            return
        }
        //TODO: remove constant
        if  (presenter?.getPaging() ?? 0) < (presenter?.getTotal() ?? 0) {
            presenter?.loadMoreData(for: searchText, pageNo: (presenter?.getPaging() ?? 0) + 1)
        }
    }
}



//MARK: Search Bar Delegates
extension SearchView: UISearchBarDelegate{
    
    // To capture searched Text
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        guard let searhedText = searchController.searchBar.text, searhedText != "" else {return}
        presenter?.fetchPhotos(for: searhedText, pageNo: 1)
    }
    
    
    // To capture the cancel event of search bar
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        clearData()
    }
    
    
    // To clear text when cross button clicked on search bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if  searchText.count == 0 {
            clearData()
        }
    }
    
    
    // Clear data from view
    private func clearData() {
        presenter?.clearData()
        collectionView.reloadData()
    }
}





extension SearchView {
    
    //  compute the scroll value and play witht the threshold to get desired effect
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        footerView?.setTransform(inTransform: CGAffineTransform.identity, scaleFactor: CGFloat(1.0))
        footerView?.animateFinal()
    }
    
    //compute the offset and call the load method
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard let animatedView = footerView, animatedView.isAnimatingFinal else { return }
        animatedView.startAnimate()
    }
    
}



// MARK: - Display Logic -
// PRESENTER -> VIEW
extension SearchView: SearchPresenterOutput, AlertService {
    
    // Display photos
    func display() {
        GCD.runOnMainThread {
            self.collectionView.reloadData()
        }
    }
    
    
    // Display Error
    func displayError(error: NetworkError) {
        GCD.runOnMainThread {
            self.showAlert(titleStr: Translation.StringConstant.error, messageStr: error.errorDescription, okButtonTitle: Translation.StringConstant.ok, cancelButtonTitle: nil, response: nil)
            self.collectionView.reloadData()
        }
    }
}


