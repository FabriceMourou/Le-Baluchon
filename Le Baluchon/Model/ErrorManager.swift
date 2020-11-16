import Foundation


enum ErrorManager: Error {
    case currencyAlert
    case weatherAlert
    case translateAlert
    
    var errorMessage: String {
        switch self {
        case .currencyAlert: return " 💵 could not get rate for conversion 💶 "
        case .weatherAlert: return " ⛈ Could not get weather informations ⛅️"
        case .translateAlert: return " 🧔 Could not get data for translate text 🤷🏻‍♂️"
    }
}

}
