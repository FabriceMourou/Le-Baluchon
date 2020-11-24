
import Foundation


enum NetworkManagerError: LocalizedError {
    case unknownError
    case badStatusCode
    case noData
    case failedToDecodeJson
    
    
    var errorDescription: String? {
        switch self {
        case .badStatusCode: return "Bad status code"
        case .failedToDecodeJson: return "Failed to decode json"
        case .noData: return "Could not get data"
        case .unknownError: return "Unknown error occured"
        }
    }
}


// MARK: Methods - Internal


protocol NetworkManagerProtocol {
    func fetch<T: Decodable>(url: URL, completion: @escaping (Result<T, NetworkManagerError>) -> Void)
    func fetchData(url: URL, completion: @escaping (Result<Data, NetworkManagerError>) -> Void)
}

class AlwaysFailNetworkManagerMock: NetworkManagerProtocol {
    func fetch<T>(url: URL, completion: @escaping (Result<T, NetworkManagerError>) -> Void) where T : Decodable {
        completion(.failure(.badStatusCode))
    }
    
    func fetchData(url: URL, completion: @escaping (Result<Data, NetworkManagerError>) -> Void) {
        completion(.failure(.failedToDecodeJson))
    }
    
    
}

class CurrencySuccessNetworkManagerMock: NetworkManagerProtocol {
    func fetch<T>(url: URL, completion: @escaping (Result<T, NetworkManagerError>) -> Void) where T : Decodable {
        let currencyResponse = CurrencyResponse(success: true, timestamp: 10, base: "euro", date: "10/04/22", rates: ["EUR":10, "USD": 15])
        completion(.success(currencyResponse as! T))
    }
    
    func fetchData(url: URL, completion: @escaping (Result<Data, NetworkManagerError>) -> Void) {
        completion(.failure(.failedToDecodeJson))
    }
    
    
}


class NetworkManager: NetworkManagerProtocol {
    
    func fetch<T: Decodable>(url: URL, completion: @escaping (Result<T, NetworkManagerError>) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                completion(.failure(.unknownError))
                return
            }
            
            guard
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200 else {
                completion(.failure(.badStatusCode))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            
            guard let decodedData = try? JSONDecoder().decode(T.self, from: data) else {
                completion(.failure(.failedToDecodeJson))
                return
            }
            
            completion(.success(decodedData))
            
        }.resume()
    }
    
    
    
    func fetchData(url: URL, completion: @escaping (Result<Data, NetworkManagerError>) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                completion(.failure(.unknownError))
                return
            }
            
            guard
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200 else {
                completion(.failure(.badStatusCode))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            
            completion(.success(data))
            
        }.resume()
    }
}
