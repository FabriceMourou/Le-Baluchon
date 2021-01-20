import Foundation


enum TranslateManagerError: Error {
    case failedToGetInformationForTranslate
    case failedTotranslate
    case failedToGetTranslateDataInformation
    case failedToCreateUrlForTranslate
}

class TranslateManager {
    
    
    private let networkManager: NetworkManagerProtocol
    private var urlComponents: URLComponentsProtocol
    
    
    init(
        networkManager: NetworkManagerProtocol = NetworkManager(),
        urlComponents: URLComponentsProtocol = URLComponents()
    ) {
        self.networkManager = networkManager
        self.urlComponents = urlComponents
    }
    
    
    
    func translateText(text: String?, sourceLanguage: Language, targetLanguage: Language, completion: @escaping (Result<String, TranslateManagerError>) -> Void) {
        
        
        guard let textInput = text else {
            completion(.failure(.failedToGetInformationForTranslate))
            return
        }
        
        
        
        guard let url = getTranslateURL(
            sourceLanguageCode: sourceLanguage.code,
            targetLanguageCode: targetLanguage.code,
            textToTranslate: textInput
        ) else {
            completion(.failure(.failedToCreateUrlForTranslate))
            return
        }
        
        networkManager.fetch(url: url) { [weak self] (result: Result<TranslateResponse, NetworkManagerError>) in
            
            
            
            switch result {
            case .success(let response):
                guard let info = response.data?.translations?.first?.translatedText else {
                    completion(.failure(.failedTotranslate))
                    return
                }
                
                completion(.success(info))
                
                
                
                
            case .failure:
                completion(.failure(.failedTotranslate))
            }
        }
    }
    
    
    private func getTranslateURL(sourceLanguageCode: String, targetLanguageCode: String, textToTranslate: String) -> URL? {
        
        urlComponents.scheme = "https"
        urlComponents.host = "translation.googleapis.com"
        urlComponents.path = "/language/translate/v2"
        urlComponents.queryItems = [
            .init(name: "q", value: textToTranslate),
            .init(name: "source", value: sourceLanguageCode),
            .init(name: "target", value: targetLanguageCode),
            .init(name: "format", value: "text"),
            .init(name: "key", value: "AIzaSyDtmMVvnki4g7JWBLlZ7rR2HgqJCsRD534")
        ]
        
        return urlComponents.url
    }
    
    
    
    
}
