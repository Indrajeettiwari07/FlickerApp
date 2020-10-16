// This class is used to fetch data from api and parse url response and send back response in completion handler


import Foundation

struct NetworkManager {
    static let environment: NetworkEnvironment = .production
    private var router = NetworkRouter<FlickerAPI>()
}


extension NetworkManager {
    
    // Checks URLResponse statusCode and returns a *NetworkResponse* case depending upon status
    // - Parameter urlResponse: URLResponse received back from URLTask
    private func parseHTTPResponse(_ urlResponse:HTTPURLResponse) -> NetworkResponse {
        switch urlResponse.statusCode {
        case 200...400:
            return .success
        case 401...500:
            return .authenticationError
        case 501...600:
            return .badRequest
        default:
            return .failed
        }
    }
    
    // Sends a  request for the reuested API endpoint and returns a completion closure with Data object or error string
    // - Parameter endPoint: Must be a type confirming EndPointType protocol
    // - Parameter completion: returns data or error string
    func fetchData<EndPoint>(_ endPoint: EndPoint, completion: @escaping NetworkCompletionBlock) where EndPoint:EndPointType{
        guard let endPointType = endPoint as? FlickerAPI else {return}
        router.request(endPoint: endPointType) {(data, response, error) in
            self.parseURLRequestData(data: data, response: response, error: error) { (data, error) in
                completion(data, error)
            }
        }
    }
    
    // Parse the URLRequest response and returns a completion closure with Data object or error string
    // - Parameter data: Data object received in URLRequest completion closure
    // - Parameter response: URLResponse object received in URLRequest completion closure
    // - Parameter error: Error object received in URLRequest completion closure
    // - Parameter completion: completion closure with Data object or error string
    private func parseURLRequestData(data: Data?, response: URLResponse?, error: Error?, completion: @escaping NetworkCompletionBlock) {
        
        if let _ = error {
            completion(nil, NetworkError.internetError)
            return
        }
        
        guard let httpURLResponse = response as? HTTPURLResponse else {
            completion(nil, NetworkError.failed)
            return
        }
        
        let networkResponse = parseHTTPResponse(httpURLResponse)
        switch networkResponse {
        case .success:
            guard let data = data else {
                completion(nil, NetworkError.noDataFouned)
                return
            }
            completion(data, nil)
        default:
            completion(nil, NetworkError.requestError)
        }
    }
}

