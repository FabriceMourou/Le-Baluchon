import Foundation


class URLSessionDataTaskFake: URLSessionDataTask {
    
    override init() { }
    
    var completionHandler: ((Data?, URLResponse?, Error?) -> Void)?
    
    var data: Data?
    var urlResponce: URLResponse?
    var responseError: Error?

    
    override func resume(){
        completionHandler?(data, urlResponce, responseError)
        
                
    }
    override func cancel() {
        
    }
}
