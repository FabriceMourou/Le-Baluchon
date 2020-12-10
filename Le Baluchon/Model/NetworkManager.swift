
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

class NetworkManagerMock<U: Decodable>: NetworkManagerProtocol {
    init(
        resultSuccessType: U.Type,
        resultFetch: Result<U, NetworkManagerError> = .failure(.badStatusCode),
        resultFetchData: Result<Data, NetworkManagerError> = .success(Data())
    ) {
        self.resultFetch = resultFetch
        self.resultFetchData = resultFetchData
    }
    
    
    let resultFetch: Result<U, NetworkManagerError>
    let resultFetchData: Result<Data, NetworkManagerError>
    
    func fetch<T>(url: URL, completion: @escaping (Result<T, NetworkManagerError>) -> Void) where T : Decodable {
        completion(resultFetch as! Result<T, NetworkManagerError>)
    }
    
    func fetchData(url: URL, completion: @escaping (Result<Data, NetworkManagerError>) -> Void) {
        completion(resultFetchData)
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
