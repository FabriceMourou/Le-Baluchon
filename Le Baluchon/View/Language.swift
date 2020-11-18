import UIKit
import Foundation

enum Language: CaseIterable {
    case english
    case french
    case spanish
    case portuguese
    case dutch
    case german

    
    
    var image: UIImage {
        switch self {
        case .dutch: return #imageLiteral(resourceName: "Dutch-Flag")
        case .english: return #imageLiteral(resourceName: "English-Flag")
        case .french: return #imageLiteral(resourceName: "French-Flag")
        case .german: return #imageLiteral(resourceName: "German-Flag")
        case .portuguese: return #imageLiteral(resourceName: "Portugese-Flag")
        case .spanish: return #imageLiteral(resourceName: "Spanish-Flag")
        }
    }
    var title: String {
        switch self {

        case .dutch: return "Dutch"
        case .english: return "English"
        case .french: return "French"
        case .german: return "German"
        case .portuguese: return "Portugese"
        case .spanish: return "Spanish"
        }
    }
    var code: String {
        switch self {
        
        case .dutch: return "nl"
        case .english: return "en"
        case .french: return "fr"
        case .german: return "de"
        case .portuguese: return "pg"
        case .spanish: return "sp"
        }
    }
}
