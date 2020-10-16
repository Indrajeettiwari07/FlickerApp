import Foundation

// Defines Endpoint to provide required properties for any API endpoint
protocol EndPointType {
    var baseURL         : URL { get }
    var path            : String { get }
    var httpMethod      : HTTPMethod { get }
    var task            : HTTPTask { get }
    var cachingPolicy   : URLRequest.CachePolicy { get }
}
