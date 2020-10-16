// This class is used to execute user events
// This class is used to interact with interactor and receive response through protocols
// This class is used to request coordinator to move to next screen.

import Foundation


class PhotoDetailPresenter {
    var photo: Photo?
    
    // MARK: - Lifecycle -
    init(photoData: Photo?) {
        photo = photoData
    }
}


// View -> Presenter
// Method to receive user events
// MARK: User Events
extension PhotoDetailPresenter: PhotoDetailPresenterInput {
    
    // Method to return photo url for row
    func getPhotoUrl() -> String? {
        guard let photo = photo else {return nil}
        let flickerImage = FlickerAPI.flickerImage(photo: photo, size: ImageSize.large)
        return flickerImage.baseURL.absoluteString + flickerImage.path
    }
}
