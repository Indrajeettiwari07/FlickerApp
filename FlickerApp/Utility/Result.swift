// This is used to send ouput as Result enum
import UIKit

enum Result <T>{
    case Success(T)
    case Failure(String)
    case Error(String)
}
