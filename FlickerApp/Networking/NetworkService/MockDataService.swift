// This class is used to mock data and fetch data from json file and use it for testing

import Foundation

struct MockDataService: NetworkServiceProtocol, JsonReader, DataModelDecoder {
    
    // Reads bundled Flicker API result json file and decods into decodable *PhotoResult* model
    // - Parameter completion: Completion closure with  *PhotoResult*  objects or error string
    func fetchData(for endPoint: FlickerAPI, completion: @escaping PhotosCompletionBlock) {
        do {
            let fileName = FileName.forMockData
            let jsonData = try dataFromJsonFile(fileName)
            guard let data = jsonData else {
                completion(nil,NetworkError.noDataFouned)
                return
            }
            
            guard let photoData =  self.decode(data: data, to: PhotoResult.self) else {
                completion(nil, NetworkError.dataParseError)
                return
            }
            completion(photoData, nil)
            
        } catch (_ ){
            completion(nil, NetworkError.noDataFouned)
        }
    }
}
