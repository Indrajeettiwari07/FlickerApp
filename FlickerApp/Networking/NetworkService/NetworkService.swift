// This class is used to return NetworkServiceProtocol, two services have been used in this class FlickerPhotoService for receiving data from api and MockDataService for mocking data for testing


import Foundation

// Completion block for network service
typealias PhotosCompletionBlock = (_ photos: PhotoResult?,_ error: NetworkError?)-> ()


// Protocol to be used to fetch photo data
protocol NetworkServiceProtocol {
    func fetchData(for endPoint: FlickerAPI, completion: @escaping PhotosCompletionBlock)
}


struct NetworkService {
    private init() {}
    
    // Method to be used to return FlickerPhotoService to receive photos from api
    static func getFlickerService() -> NetworkServiceProtocol {
        return FlickerPhotoService()
    }
    
    // Method to be used to return offline service for testing
    static func getMockService() -> NetworkServiceProtocol {
        return MockDataService()
    }
}
