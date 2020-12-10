import Foundation



enum CurrencyManagerError: Error {
    case failedToGetInformationForConversion
    case failedToConvertValue
    case failedToGetRatesForConversion
    case failedToCreateUrlForConversion
}

class CurrencyManager {
    
    init(
        networkManager: NetworkManagerProtocol = NetworkManager(),
        numberFormatter: NumberFormatterProtocol = NumberFormatter(),
        urlComponents: URLComponentsProtocol = URLComponents()
    ) {
        self.networkManager = networkManager
        self.numberFormatter = numberFormatter
        self.urlComponents = urlComponents
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
    private let numberFormatter: NumberFormatterProtocol
    private var urlComponents: URLComponentsProtocol
    
    private func getConvertValueWithRateURL() -> URL? {
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
        
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.groupingSeparator = " "
        numberFormatter.groupingSize = 3
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
    
        
        return numberFormatter.string(from: finalResult)
    }
    
    

    
}


class URLComponentsMock: URLComponentsProtocol {
    var scheme: String? = ""
    
    var host: String? = ""
    
    var path: String = ""
    
    var queryItems: [URLQueryItem]? = []
    
    var url: URL? = nil
    
    
}


protocol URLComponentsProtocol {
    var scheme: String? { get set }
    var host: String? { get set }
    var path: String { get set }
    var queryItems: [URLQueryItem]? { get set }
    var url: URL? { get }
}


extension URLComponents: URLComponentsProtocol { }



