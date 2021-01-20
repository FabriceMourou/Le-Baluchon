import Foundation
@testable import Le_Baluchon

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
