
import Foundation





// MARK: Methods - Internal


protocol NetworkManagerProtocol {
    func fetch<T: Decodable>(url: URL, completion: @escaping (Result<T, NetworkManagerError>) -> Void)
    func fetchData(url: URL, completion: @escaping (Result<Data, NetworkManagerError>) -> Void)
}



class NetworkManager: NetworkManagerProtocol {
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    
    
    let session: URLSession
    
    func fetch<T: Decodable>(url: URL, completion: @escaping (Result<T, NetworkManagerError>) -> Void) {
        
        
        session.dataTask(with: url) { (data, response, error) in
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
        session.dataTask(with: url) { (data, response, error) in
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
