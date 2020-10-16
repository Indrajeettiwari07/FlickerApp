
import Foundation

// Model to be used to fetch data from api and convert them into photo model
struct Photo: Codable {
    var farm : Int
    var server : String
    var secret : String
    var id: String
}



// Model to be used to fetch data from api and convert them into photos model
struct Photos: Codable {
    var page: Int
    var pages: Int
    var perpage: Int
    var total:String
    var photo:[Photo]
}


// Model to be used to extract photo result from api
struct PhotoResult: Codable {
    var stat: String
    var photos: Photos
}

