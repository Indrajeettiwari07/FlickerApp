// This class is used to fetch data from api and convert them to PhotoResult

import Foundation

struct FlickerPhotoService: NetworkServiceProtocol, DataModelDecoder {
    
    // MARK: - Properties -
    var networkManager: NetworkManager
    
    // MARK: - Lifecycle -
    init() {
        networkManager = NetworkManager()
    }
    
    
    // Retrieve data form Flicker API and decods into decodable *Photos* model
    // - Parameter completion: Completion closure with  *Photos*  objects or error string
    func fetchData(for endPoint: FlickerAPI, completion: @escaping PhotosCompletionBlock) {
        networkManager.fetchData(endPoint, completion: { data, error in
            guard let data = data else {
                completion(nil,NetworkError.noDataFouned)
                return
            }
            
            guard let photo =  self.decode(data: data, to: PhotoResult.self) else {
                completion(nil, NetworkError.dataParseError)
                return
            }
            completion(photo, nil)
            
        })
    }
}



