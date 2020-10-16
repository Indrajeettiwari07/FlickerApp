// This class helps in network related operation, this class provides network error and its description

import Foundation

enum NetworkError: Error {
    
    // MARK: - Cases
    case dataParseError
    case invalidPath
    case parseError
    case requestError
    case internetError
    case failed
    case noDataFouned
    
    var errorDescription:String {
        switch self {
        case .dataParseError, .invalidPath, .parseError, .requestError, .failed, .noDataFouned:
            return Translation.NetworkCosntant.errorMessage
        case .internetError:
            return Translation.NetworkCosntant.noInternetError
        }
    }
}




// For Setting network envoirenment of the app
enum NetworkEnvironment {
    case staging
    case production
    case development
}

// Defines network response status and provides error strings for network request error
enum NetworkResponse: String {
    case success
    case authenticationError    = "Authentication Error"
    case badRequest             = "Bad Request"
    case failed                 = "Network request Failed"
    case noData                 = "No Data Found"
    case unableToDecode         = "Decoding Error"
    case noInternet             = "No Internet Connectivity."
}


// Completion handler to return data and error
typealias NetworkCompletionBlock = (_ data: Data?,_ error: Error?)-> ()


enum ApiEndPoint {
    case searchPhoto
    case flickerImage
    
    // url endpoint for Flicker apis
    var urlString: String {
        switch self {
        case .searchPhoto:
            return "https://api.flickr.com/services/rest/"
        case .flickerImage:
            return "https://farm"
        }
    }
}
