
import Foundation


enum NetworkManagerError: Error {
    case unknownError
    case badStatusCode
    case noData
    case failedToDecodeJson
}


// MARK: Methods - Internal


class NetworkManager {
    
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
}
