import Foundation
@testable import Le_Baluchon



class NumberFormatterMock: NumberFormatterProtocol {
    var usesGroupingSeparator: Bool = true
    
    var groupingSeparator: String! = ""
    
    var groupingSize: Int = 0
    
    var numberStyle: NumberFormatter.Style = .decimal
    
    var minimumFractionDigits: Int = 0
    
    var maximumFractionDigits: Int = 0
    
    func string(from number: NSNumber) -> String? {
        nil
    }
    
    
}
