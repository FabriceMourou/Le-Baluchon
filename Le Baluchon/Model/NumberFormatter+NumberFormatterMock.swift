import Foundation

extension NumberFormatter: NumberFormatterProtocol { }


protocol NumberFormatterProtocol: class {
    var usesGroupingSeparator: Bool { get set }
    var groupingSeparator: String! { get set }
    var groupingSize: Int { get set }
    var numberStyle: NumberFormatter.Style { get set }
    var minimumFractionDigits: Int { get set }
    var maximumFractionDigits: Int { get set }
    
    
    func string(from number: NSNumber) -> String?
    
    
}
