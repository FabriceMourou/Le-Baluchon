import Foundation

// MARK: - Internal

// MARK: Properties - Internal

enum Currency {
    case dollar, euro
    
    
    var symbol: String {
        switch self {
        case .dollar: return "$"
        case .euro: return "€"
        }
    }
    
    var code: String {
        switch self {
        case .dollar: return "USD"
        case .euro: return "EUR"
        }
    }
}





