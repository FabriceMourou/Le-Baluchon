import Foundation


class FakeResponseData{
    
    static var networkManagerCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "", withExtension: "")!
        return try! Data(contentsOf: url)
    }
    
    static let networkManagerIncorrectData = "erreur".data(using: .utf8)!
    

    
    static let url =  URL(string: "https://www.swiftbysundell.com")!
    
    static let responseOK = HTTPURLResponse(
        url: url,
        statusCode: 200, httpVersion: nil, headerFields: nil)!

    static let responseKO = HTTPURLResponse(
        url: url,
        statusCode: 500, httpVersion: nil, headerFields: nil)!
    
    
    
    

    
    
    
    
    
    
    
}
