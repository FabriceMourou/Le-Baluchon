//
//  NetworkManagerTests.swift
//  Le BaluchonTests
//
//  Created by Fabrice Mourou on 12/01/2021.
//

@testable import Le_Baluchon
import XCTest



class CodableObjectMock: Codable { }

class NetworkManagerTests: XCTestCase {
    
    
    
    
    func testGivenErrorButNoResponseNoDataWhenFetchThenGetUnknownError() {
        let urlSessionFake = URLSessionFake(data: nil, response: nil, error: NetworkManagerError.noData)
        let networkManager = NetworkManager(session: urlSessionFake)
        
        networkManager.fetch(url: FakeResponseData.url) { (result: Result<CodableObjectMock, NetworkManagerError>) in
            switch result {
            case .success:
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error, .unknownError)
            }
        }
    }
    
    func testGivenNoErrorBadResponseAndNoDataWhenFetchThenGetBadStatusCodeError() {
        let urlSessionFake = URLSessionFake(data: nil, response: FakeResponseData.responseKO, error: nil)
        let networkManager = NetworkManager(session: urlSessionFake)
        
        networkManager.fetch(url: FakeResponseData.url) { (result: Result<CodableObjectMock, NetworkManagerError>) in
            switch result {
            case .success:
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error, .badStatusCode)
            }
        }
    }
    
    
    func testGivenNoErrorGoodResponseAndNoDataWhenFetchThenGetNoDataError() {
        let urlSessionFake = URLSessionFake(data: nil, response: FakeResponseData.responseOK, error: nil)
        let networkManager = NetworkManager(session: urlSessionFake)
        
        networkManager.fetch(url: FakeResponseData.url) { (result: Result<CodableObjectMock, NetworkManagerError>) in
            switch result {
            case .success:
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error, .noData)
            }
        }
    }
    
    func testGivenNoErrorGoodResponseAndInvalidDataWhenFetchThenGetFailedToDecodeError() {
        let urlSessionFake = URLSessionFake(data: Data(), response: FakeResponseData.responseOK, error: nil)
        let networkManager = NetworkManager(session: urlSessionFake)
        
        networkManager.fetch(url: FakeResponseData.url) { (result: Result<CodableObjectMock, NetworkManagerError>) in
            switch result {
            case .success:
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error, .failedToDecodeJson)
            }
        }
    }
    
    func testGivenNoErrorGoodResponseAndValidDataWhenFetchThenSucceed() {
        let fakeData = "\"\"".data(using: .utf8)
        let urlSessionFake = URLSessionFake(data: fakeData, response: FakeResponseData.responseOK, error: nil)
        let networkManager = NetworkManager(session: urlSessionFake)
        
        networkManager.fetch(url: FakeResponseData.url) { (result: Result<CodableObjectMock, NetworkManagerError>) in
            switch result {
            case .success:
                XCTAssertTrue(true)
            case .failure:
               XCTFail()
            }
        }
    }
    
    
    
    
    
    
    
    func testGivenErrorButNoResponseNoDataWhenFetchDataThenGetUnknownError() {
        let urlSessionFake = URLSessionFake(data: nil, response: nil, error: NetworkManagerError.noData)
        let networkManager = NetworkManager(session: urlSessionFake)
        
        networkManager.fetchData(url: FakeResponseData.url) { result in
            switch result {
            case .success:
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error, .unknownError)
            }
        }
    }
    
    func testGivenNoErrorBadResponseAndNoDataWhenFetchDataThenGetBadStatusCodeError() {
        let urlSessionFake = URLSessionFake(data: nil, response: FakeResponseData.responseKO, error: nil)
        let networkManager = NetworkManager(session: urlSessionFake)
        
        networkManager.fetchData(url: FakeResponseData.url) { result in
            switch result {
            case .success:
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error, .badStatusCode)
            }
        }
    }
    
    
    func testGivenNoErrorGoodResponseAndNoDataWhenFetchDataThenGetNoDataError() {
        let urlSessionFake = URLSessionFake(data: nil, response: FakeResponseData.responseOK, error: nil)
        let networkManager = NetworkManager(session: urlSessionFake)
        
        networkManager.fetchData(url: FakeResponseData.url) { result in
            switch result {
            case .success:
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error, .noData)
            }
        }
    }
    
    
    func testGivenNoErrorGoodResponseAndValidDataWhenFetchDataThenSucceed() {
        let fakeData = "\"\"".data(using: .utf8)
        let urlSessionFake = URLSessionFake(data: fakeData, response: FakeResponseData.responseOK, error: nil)
        let networkManager = NetworkManager(session: urlSessionFake)
        
        networkManager.fetchData(url: FakeResponseData.url) { result in
            switch result {
            case .success:
                XCTAssertTrue(true)
            case .failure:
               XCTFail()
            }
        }
    }
    
    
}
