

import Foundation

enum WeatherManagerError: Error {
    case failedToGetInformationForWeather
    case failedToConvertValue
    case failedToGetWeatherDataInformation
    case failedToCreateUrlForWeather
}


class WeatherManager {
    
    
    
    private let networkManager = NetworkManager()
  
    
    func displaysWeatherDataFromCity(cityName: String?, completion: @escaping (Result<String, WeatherManagerError>) -> Void) {
        
        guard let url = getWeatherValuesURL(cityName: cityName!) else {
            completion(.failure(.failedToCreateUrlForWeather))
            return
        }
        
        networkManager.fetch(url: url) { [weak self](result: Result<WeatherResponse,  NetworkManagerError>) in
            
            
            switch result {
            case .success(let response):
                guard let info =
                        response.base else {
                    completion( .failure(.failedToGetInformationForWeather))
                    return 
                }
                completion(.success(info))
                
            case .failure:
                completion(.failure(.failedToGetWeatherDataInformation))
                
            }
        }
        
    }

    
    private var weatherResponse: WeatherResponse?
    
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
