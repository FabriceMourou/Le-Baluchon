

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


class WeatherManager {
    
    enum WeatherManagerError: Error {
        case failedToGetInformationForWeather
        case failedToConvertValue
        case failedToGetWeatherDataInformation
        case failedToCreateUrlForWeather
        
        case failedToGetWeatherIconImageData
        case failedToCreateUrlForWeatherIconImageData
    }
    
    
    private let networkManager = NetworkManager()
    private let weatherValuesFormatter = WeatherValuesFormatter()
    private var weatherResponse: WeatherResponse?
    
    func getWeatherDataFromCity(cityName: String?, completion: @escaping (Result<FormattedWeatherData, WeatherManagerError>) -> Void) {
        
        guard let cityInput = cityName else {
            completion(.failure(.failedToGetInformationForWeather))
            return
        }
        
        guard let url = getWeatherValuesURL(cityName: cityInput) else {
            completion(.failure(.failedToConvertValue))
            return
        }
        
        networkManager.fetch(url: url) { [weak self](result: Result<WeatherResponse,  NetworkManagerError>) in
            
            
            switch result {
            case .success(let response):
                
                guard let main = response.main else {
                    completion( .failure(.failedToGetInformationForWeather))
                    return 
                }
                
                let value1 = self?.weatherValuesFormatter.getFormattedTemperature(from: main.temp)
                let value2 = self?.weatherValuesFormatter.getFormattedTemperature(from: main.feelsLike)
                let value3 = self?.weatherValuesFormatter.getFormattedTemperature(from: main.tempMax)
                let value4 = self?.weatherValuesFormatter.getFormattedTemperature(from: main.tempMin)
                let value5 = self?.weatherValuesFormatter.getFormattedPercentage(from: response.clouds?.all)
                let value6 = self?.weatherValuesFormatter.getFormattedPercentage(from: main.humidity)
                let value7 = response.name
                let value8 = response.sys?.country
                let value9 = response.coord?.lon?.description
                let value10 = response.coord?.lat?.description
                let value11 = response.weather?.first?.weatherDescription
                let value12 = response.weather?.first?.icon
                
                let formattedWeatherData = FormattedWeatherData(
                    temperature: value1,
                    feelLikeTemperature: value2,
                    highTemperature: value3,
                    lowTemperature: value4,
                    percentageCloudiness: value5,
                    percentageHumidity: value6,
                    cityName:  value7,
                    cityCountry: value8,
                    longitude: value9,
                    latitude: value10,
                    description: value11,
                    iconId: value12
                )
                
                completion(.success(formattedWeatherData))
                
                
            case .failure:
                
                completion(.failure(.failedToGetWeatherDataInformation))
                
            }
        }
        
    }
    
    
    func getWeatherIconImage(iconId: String, completion: @escaping (Result<Data, WeatherManagerError>) -> Void) {
        guard let iconUrl = URL(string: "http://openweathermap.org/img/wn/\(iconId)@2x.png") else {
            completion(.failure(.failedToCreateUrlForWeatherIconImageData))
            return
        }
        
        networkManager.fetchData(url: iconUrl) { [weak self] (result) in
            
            switch result {
            case .success(let iconImageData):
                completion(.success(iconImageData))
                
            case .failure:
                completion(.failure(.failedToGetWeatherIconImageData))
            }
            
        }
    }

    
    
    
    private func getWeatherValuesURL(cityName: String) -> URL? {
        
        var urlComponents = URLComponents()
        
        urlComponents.scheme = "http"
        urlComponents.host = "api.openweathermap.org"
        urlComponents.path = "/data/2.5/weather"
        urlComponents.queryItems = [
            .init(name: "q", value: cityName),
            .init(name: "appid", value: "022b0764cc4f75219db52fb5bb71cd2b"),
            .init(name: "units", value: "metric")
        ]
        
        return urlComponents.url
    }
    
    
}
