
import Foundation

enum NetworkManagerError: LocalizedError {
    case unknownError
    case badStatusCode
    case noData
    case failedToDecodeJson
    
    
    var errorDescription: String? {
        switch self {
        case .badStatusCode: return "Bad status code"
        case .failedToDecodeJson: return "Failed to decode json"
        case .noData: return "Could not get data"
        case .unknownError: return "Unknown error occured"
        }
    }
}
