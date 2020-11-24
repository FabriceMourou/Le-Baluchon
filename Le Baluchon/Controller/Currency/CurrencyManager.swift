import Foundation



enum CurrencyManagerError: Error {
    case failedToGetInformationForConversion
    case failedToConvertValue
    case failedToGetRatesForConversion
    case failedToCreateUrlForConversion
}

class CurrencyManager {
    
    init(networkManager: NetworkManagerProtocol = NetworkManager()) {
        self.networkManager = networkManager
    }

    
    func convertValueWithRate(value: Double, sourceCurrency: Currency, targetCurrency: Currency, completion: @escaping (Result<String, CurrencyManagerError>) -> Void)   {
        
        
        guard let url = getConvertValueWithRateURL() else {
            
            completion(.failure(.failedToCreateUrlForConversion))
            return
        }
        
        networkManager.fetch(url: url) { [weak self] (result: Result<CurrencyResponse, NetworkManagerError>) in
            switch result {
            case .success(let response):
                
                guard
                    let sourceRate = response.rates[sourceCurrency.code],
                    let targetRate = response.rates[targetCurrency.code]
                else {
                    completion(.failure(.failedToGetRatesForConversion))
                    return
                }
                
                let conversionRate = targetRate / sourceRate
                let convertedValue = conversionRate * value
                
               
                
                guard let formattedResult = self?.formatValue(valueToConvert: convertedValue) else {
                    completion(.failure(.failedToConvertValue))
                    return
                }
                
                completion(.success(formattedResult))
                return
                
                
                
            case .failure:
                
                completion(.failure(.failedToGetInformationForConversion))
                return
            }
            
            
        }
        
    }
    
    
    private let networkManager: NetworkManagerProtocol
    
    private func getConvertValueWithRateURL() -> URL? {
        
        var urlComponents = URLComponents()
        
        urlComponents.scheme = "http"
        urlComponents.host = "data.fixer.io"
        urlComponents.path = "/api/latest"
        urlComponents.queryItems = [
            URLQueryItem(name: "access_key", value: "3d2ba3bcfe5a29250698c07e1ac37680")
        ]
        
        return urlComponents.url
    }
    
    
    private func formatValue(valueToConvert: Double) -> String? {
        let finalResult = valueToConvert as NSNumber
        
        let formattedValue = NumberFormatter()
        
        formattedValue.usesGroupingSeparator = true
        formattedValue.groupingSeparator = " "
        formattedValue.groupingSize = 3
        formattedValue.numberStyle = .decimal
        formattedValue.minimumFractionDigits = 2
        formattedValue.maximumFractionDigits = 2
        
        
        return formattedValue.string(from: finalResult)
    }
    
    

    
}


