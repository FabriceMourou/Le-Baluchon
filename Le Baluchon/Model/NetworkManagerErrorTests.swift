
@testable import Le_Baluchon

import XCTest

class NetworkManagerErrorTests: XCTestCase {
    
    
    func testGivenUnknownErrorWhenGetErrorThenProvideCorrectInfo() {
        let error = NetworkManagerError.unknownError
        
        let info = error.errorDescription
        
        XCTAssertEqual(info, "Unknown error occured")
    }
    
    
    func testGivenBadStatusCodeErrorWhenGetErrorThenProvideCorrectInfo() {
        let error = NetworkManagerError.badStatusCode
        
        let info = error.errorDescription
        
        XCTAssertEqual(info, "Bad status code")
    }
    
    
    func testGivenNoDataErrorWhenGetErrorThenProvideCorrectInfo() {
        let error = NetworkManagerError.noData
        
        let info = error.errorDescription
        
        XCTAssertEqual(info, "Could not get data")
    }
    
    
    
    func testGivenFailedToDecodeJsonErrorWhenGetErrorThenProvideCorrectInfo() {
        let error = NetworkManagerError.failedToDecodeJson
        
        let info = error.errorDescription
        
        XCTAssertEqual(info, "Failed to decode json")
    }
    
}
