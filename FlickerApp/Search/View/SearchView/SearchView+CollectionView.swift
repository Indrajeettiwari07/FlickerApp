// This class is used to create collection view
import UIKit

// MARK: UICollectionViewDataSource
extension SearchView {
    
    // Number of section in collection view
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return presenter?.numberOfSections() ?? 0
    }
    
    
    // Number of rows in collection view
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.numberOfRowsInSection() ?? 0
    }
    
    
    // Configure cell
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FlickrPhotoCell.identifier, for: indexPath) as? FlickrPhotoCell else {
            return UICollectionViewCell()
        }
        
        return cell
    }
    
    
    // Load more photos if required
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let lastRowIndex = collectionView.numberOfItems(inSection: 0) - 1
        if indexPath.row == lastRowIndex && presenter?.getPaging() != 0 {
            
            GCD.runAsynchAfter(delay: 0.5, closure: {
                self.loadMorePhotos()
            })
        }
        
        guard let flickrPhoto = presenter?.photoURL(for: indexPath.row) else {return}
        guard let cell = cell as? FlickrPhotoCell else {return}
        // cell.photoView.loadImage(urlString: flickrPhoto)
        cell.photoView.downloadImage(flickrPhoto)
    }
    
    
    // To capture row selction
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.showDetail(for: indexPath.row)
    }
}


//MARK: UICollectionViewDelegateFlowLayout
extension SearchView: UICollectionViewDelegateFlowLayout {
    
    // Configure layout the size of a given cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Total amount of space taken up by padding
        // there will be n + 1 evenly sized spaces, where n is the number of items in the row
        // the space size is taken from the left section inset
        // subtracting this from the view's width and dividing by the number of items in a row gives the width for each item
        let paddingSpace = SearchedItem.sectionInsets.left * (SearchedItem.itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / SearchedItem.itemsPerRow
        // return the size as a square
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    
    // return the spacing between the cells, headers, and footers. Used a constant for that
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return SearchedItem.sectionInsets
    }
    
    
    // controls the spacing between each line in the layout. this should be matched the padding at the left and right
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return SearchedItem.sectionInsets.left
    }
    
    
    // Layout size for the footer
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard searchController.searchBar.text != "" else { return CGSize.zero }
        guard !(presenter?.isLoading ?? false) else { return CGSize.zero }
        return CGSize(width: collectionView.bounds.size.width, height: 55)
    }
}



//MARK: Collection View header and footer delegates
extension SearchView {
    
    // Method to configure supplementary view
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            guard let aFooterView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: FooterView.reusableIdentifier, for: indexPath) as? FooterView else {return UICollectionReusableView()}
            footerView = aFooterView
            footerView?.backgroundColor = UIColor.clear
            return aFooterView
        }else {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier:  FooterView.reusableIdentifier, for: indexPath)
            return headerView
        }
    }
    
    
    // Prepare footerview for initial animation
    override func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter {
            footerView?.prepareInitialAnimation()
        }
    }
    
    
    // Stop animation on footer view disappearance
    override func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter {
            footerView?.stopAnimate()
        }
    }
}
