

import Foundation

enum WeatherManagerError: Error {
    case failedToGetInformationForWeather
    case failedToConvertValue
    case failedToGetWeatherDataInformation
    case failedToCreateUrlForWeather
    case failedToGetWeatherIconImageData
    case failedToCreateUrlForWeatherIconImageData
}

class WeatherManager {
    
    private let networkManager: NetworkManagerProtocol
    private let weatherValuesFormatter = WeatherValuesFormatter()
    private var weatherResponse: WeatherResponse?
    private var urlComponents: URLComponentsProtocol
    
    

    init(
        networkManager: NetworkManagerProtocol = NetworkManager(),
        urlComponents: URLComponentsProtocol = URLComponents()
    ) {
        self.networkManager = networkManager
        self.urlComponents = urlComponents
    }
    

    
    func getWeatherDataFromCity(cityName: String?, completion: @escaping (Result<FormattedWeatherData, WeatherManagerError>) -> Void) {
        
        guard let cityInput = cityName else {
            completion(.failure(.failedToConvertValue))
            return
        }
        
        guard let url = getWeatherValuesURL(cityName: cityInput) else {
            completion(.failure(.failedToCreateUrlForWeather))
            return
        }
        
        networkManager.fetch(url: url) { [weak self](result: Result<WeatherResponse,  NetworkManagerError>) in
            
            
            switch result {
            case .success(let response):
                
                guard let main = response.main else {
                    completion( .failure(.failedToGetInformationForWeather))
                    return 
                }
                
                let cityTemperature = self?.weatherValuesFormatter.getFormattedTemperature(from: main.temp)
                let feelLikeTemperature = self?.weatherValuesFormatter.getFormattedTemperature(from: main.feelsLike)
                let cityTemperatureMax = self?.weatherValuesFormatter.getFormattedTemperature(from: main.tempMax)
                let cityTemperatureMin = self?.weatherValuesFormatter.getFormattedTemperature(from: main.tempMin)
                let percentageCloudiness = self?.weatherValuesFormatter.getFormattedPercentage(from: response.clouds?.all)
                let percentageHumidity = self?.weatherValuesFormatter.getFormattedPercentage(from: main.humidity)
                let cityName = response.name
                let country = response.sys?.country
                let longitude = response.coord?.lon?.description
                let latitude = response.coord?.lat?.description
                let weatherDescription = response.weather?.first?.weatherDescription
                let weatherIcon = response.weather?.first?.icon
                
                let formattedWeatherData = FormattedWeatherData(
                    temperature: cityTemperature,
                    feelLikeTemperature: feelLikeTemperature,
                    highTemperature: cityTemperatureMax,
                    lowTemperature: cityTemperatureMin,
                    percentageCloudiness: percentageCloudiness,
                    percentageHumidity: percentageHumidity,
                    cityName:  cityName,
                    cityCountry: country,
                    longitude: longitude,
                    latitude: latitude,
                    description: weatherDescription,
                    iconId: weatherIcon
                )
                
                completion(.success(formattedWeatherData))
                
                
            case .failure:
                
                completion(.failure(.failedToGetWeatherDataInformation))
                
            }
        }
        
    }
    
    
    func getWeatherIconImage(iconId: String, completion: @escaping (Result<Data, WeatherManagerError>) -> Void) {
        guard let iconUrl = getWeatherIconUrl(iconId: iconId) else {
            completion(.failure(.failedToCreateUrlForWeatherIconImageData))
            return
        }
        
        networkManager.fetchData(url: iconUrl) { (result) in
            
            switch result {
            case .success(let iconImageData):
                completion(.success(iconImageData))
                
            case .failure:
                completion(.failure(.failedToGetWeatherIconImageData))
            }
            
        }
    }
    
    private func getWeatherValuesURL(cityName: String) -> URL? {

        
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
    
    
    
    private func getWeatherIconUrl(iconId: String) -> URL? {
        
        
        urlComponents.scheme = "http"
        urlComponents.host = "openweathermap.org"
        urlComponents.path = "/img/wn/\(iconId)@2x.png"
        
        return urlComponents.url
    }
    
    
}
