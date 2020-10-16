// This class is used to receive user events and pass it to presenter
// This class is used to creat UI and adjust it.

import UIKit

class PhotoDetail: UIViewController {
    
    // MARK: - IBOUTLets -
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - Properties -
    var presenter: PhotoDetailPresenter?
}


//MARK: LifeCycle
extension PhotoDetail {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set Title
        self.title = Translation.PhotoDetail.title
        
        // Configure ScrollView
        configureScrollView()
        
        //Load Image
        loadImage()
    }
    
    
    // Configure Scroll View Delegates
    private func configureScrollView() {
        scrollView.minimumZoomScale = ScrollViewContstant.minimumZoomScale
        scrollView.maximumZoomScale = ScrollViewContstant.maximumZoomScale
        scrollView.delegate = self
    }
    
    
    // Load image
    private func loadImage() {
        guard let imageURLString = presenter?.getPhotoUrl() else {return}
        // imageView.loadImage(urlString: imageURLString)
        imageView.downloadImage(imageURLString)
    }
}


// MARK: UIScrollView Delegates
extension PhotoDetail: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        for view in scrollView.subviews where view is UIImageView {
            return view as? UIImageView
        }
        return nil
    }
}
