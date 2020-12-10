
import Foundation



class WeatherValuesFormatter {
    func getFormattedTemperature(from unformattedTemperature: Double) -> String? {
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .none
        numberFormatter.roundingMode = .halfDown
        guard let formattedNumber =  numberFormatter.string(from: unformattedTemperature as NSNumber) else { return nil }
        
        return formattedNumber +  "°c"
        
    }
    
    func getFormattedPercentage(from unformattedPercentage: Double) -> String? {
        let percentageFormatter = NumberFormatter()
        guard let formattedPercentage = percentageFormatter.string(from: unformattedPercentage as NSNumber) else { return nil }
        return formattedPercentage + "%"
        
    }
    
    
    
}
