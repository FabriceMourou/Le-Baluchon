import XCTest
@testable import Le_Baluchon

class TranslateManagerTest: XCTestCase {
    
    
    private var translateManager: TranslateManager!
    
    override func setUp() {
        super.setUp()
        translateManager = TranslateManager()
    }
    
    
    
    
    func test_givenInvalidResponse_whenTranslateText_thenFailedToTranslate () throws {
        
        let networkManagerMock = NetworkManagerMock(
            resultSuccessType: TranslateResponse.self,
            resultFetch: .failure(.unknownError)
        )
        
        let translateManager = TranslateManager(networkManager: networkManagerMock)
        
        translateManager.translateText(text: "bonjour",
                                       sourceLanguage: .french,
                                       targetLanguage: .english) { (result) in
            
            switch result {
            case .success:
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error, .failedTotranslate)
            }
            
        }
    }
    
    func test_givenNormalText_whenTranslateText_thenGetCorrectTranslatedText() throws {
        
        let translateResponse = TranslateResponse(data: DataClass(translations: [Translation(translatedText: "Hello")]))
        
        let networkManagerMock = NetworkManagerMock(
            resultSuccessType: TranslateResponse.self,
            resultFetch: .success(translateResponse)
        )
        
        let translateManager = TranslateManager(networkManager: networkManagerMock)
        
        translateManager.translateText(text: "Bonjour", sourceLanguage: .french, targetLanguage: .english ) { (result) in
            switch result {
            case .success(let translatedText):
                XCTAssertEqual(translatedText, "Hello")
            case .failure:
               XCTFail()
            }
        }
    }
    
    
    func test_givenNoText_whenTranslateText_thenGetFailedToGetInformationForTranslate() throws {
        
//        let translateResponse = TranslateResponse(data: DataClass(translations: [Translation(translatedText: "")]))
//
//        let networkManagerMock = NetworkManagerMock(
//            resultSuccessType: TranslateResponse.self,
//            resultFetch: .success(.badStatusCode)
//        )
        
        let translateManager = TranslateManager()
        
        translateManager.translateText(text: nil, sourceLanguage: .french, targetLanguage: .english ) { (result) in
            switch result {
            case .success:
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error, .failedToGetInformationForTranslate)
            }
        }
    }
    
    func test_givenAlwaysFailUrlComponent_whenGetUrl_getFailedToCreateUrlForTranslate() {
        let failUrlComponents = URLComponentsMock()
        let translateManager = TranslateManager(urlComponents: failUrlComponents)
        
        translateManager.translateText(text: "Bonjour", sourceLanguage: .french, targetLanguage: .english ) { (result) in
            switch result {
            case .success:
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error, .failedToCreateUrlForTranslate)
            }
        }
    }
    
    
    func test_givenNormalText_whenTranslateText_thenFailedToConvertTranslatedText() throws {
        
        let translateResponse = TranslateResponse(data: DataClass(translations: []))
        
        let networkManagerMock = NetworkManagerMock(
            resultSuccessType: TranslateResponse.self,
            resultFetch: .success(translateResponse)
        )
        
        let translateManager = TranslateManager(networkManager: networkManagerMock)
        
        translateManager.translateText(text: "Bonjour", sourceLanguage: .french, targetLanguage: .english ) { (result) in
            switch result {
            
            case .success:
                XCTFail()
                
            case .failure(let error):
                XCTAssertEqual(error, .failedTotranslate)
            

            }
        }
    }
    
    
    
    
}









