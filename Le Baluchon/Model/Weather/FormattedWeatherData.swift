import Foundation


class FormattedWeatherData {
    init(temperature: String?, feelLikeTemperature: String?, highTemperature: String?, lowTemperature: String?, percentageCloudiness: String?, percentageHumidity: String?, cityName: String?, cityCountry: String?, longitude: String?, latitude: String?, description: String?, iconId: String?) {
        self.temperature = temperature
        self.feelLikeTemperature = feelLikeTemperature
        self.highTemperature = highTemperature
        self.lowTemperature = lowTemperature
        self.percentageCloudiness = percentageCloudiness
        self.percentageHumidity = percentageHumidity
        self.cityName = cityName
        self.cityCountry = cityCountry
        self.longitude = longitude
        self.latitude = latitude
        self.description = description
        self.iconId = iconId
    }
    
    let temperature: String?
    let feelLikeTemperature: String?
    
    let highTemperature: String?
    let lowTemperature: String?
    
    let percentageCloudiness: String?
    let percentageHumidity: String?
    
    let cityName: String?
    let cityCountry: String?
    
    let longitude: String?
    let latitude: String?
    
    let description: String?
    let iconId: String?
    
}
