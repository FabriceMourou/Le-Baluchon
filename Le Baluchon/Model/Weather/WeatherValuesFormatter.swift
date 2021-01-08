
import Foundation



class WeatherValuesFormatter {
    func getFormattedTemperature(from unformattedTemperature: Double?) -> String? {
        guard let unformattedTemperature = unformattedTemperature else { return nil }
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .none
        numberFormatter.roundingMode = .halfDown
        guard let formattedNumber =  numberFormatter.string(from: unformattedTemperature as NSNumber) else { return nil }
        
        return formattedNumber +  "°c"
        
    }
    
    func getFormattedPercentage(from unformattedPercentage: Int?) -> String? {
        guard let unformattedPercentage = unformattedPercentage else { return nil }
        
        let percentageFormatter = NumberFormatter()
        guard let formattedPercentage = percentageFormatter.string(from: unformattedPercentage as NSNumber) else { return nil }
        return formattedPercentage + "%"
        
    }
    
    
    
}
