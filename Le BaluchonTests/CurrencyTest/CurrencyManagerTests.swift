import XCTest
@testable import Le_Baluchon

class CurrencyManagerTests: XCTestCase {
    
    
    private var currencyManager: CurrencyManager!
    
    
    override func setUp() {
        super.setUp()
        currencyManager = CurrencyManager()
    }
    

    
    func test_givenInvalidResponse_whenConvertValueWithRate_thenGetFailedToGetInformationForConversionError() throws {
        
        // Given
        
        let networkManagerMock = NetworkManagerMock(
            resultSuccessType: CurrencyResponse.self,
            resultFetch: .failure(.unknownError)
        )
        
        let currencyManager = CurrencyManager(networkManager: networkManagerMock)
        
        // When
        
        currencyManager.convertValueWithRate(value: 100, sourceCurrency: .dollar, targetCurrency: .euro) { (result) in
            
        // Then
            switch result {
            case .success:
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error, .failedToGetInformationForConversion)
            }
        }
    }
    
    
    func test_givenNormalValue_whenConvertValueWithRate_thenGetCorrectFormattedValueAsString() throws {
        
        let currencyResponse = CurrencyResponse(success: true, timestamp: 1606844045, base: "EUR", date: "2020-12-01", rates: ["EUR": 1.1, "USD": 1.0])
        
        let networkManagerMock = NetworkManagerMock(
            resultSuccessType: CurrencyResponse.self,
            resultFetch: .success(currencyResponse)
        )
        
        let currencyManager = CurrencyManager(networkManager: networkManagerMock)
        
        currencyManager.convertValueWithRate(value: 100, sourceCurrency: .dollar, targetCurrency: .euro) { (result) in
            switch result {
            case .success(let convertedValue):
                XCTAssertEqual(convertedValue, "110.00")
            case .failure:
               XCTFail()
            }
        }
    }
    
    
    func test_givenNormalValue_whenConvertValueWithRate_thenGetfailedToGetRatesForConversion() throws {
        
        let currencyResponse = CurrencyResponse(success: true, timestamp: 1606844045, base: "EUR", date: "2020-12-01", rates: ["EUR": 1.1, "CHF": 1.0])
        
        let networkManagerMock = NetworkManagerMock(
            resultSuccessType: CurrencyResponse.self,
            resultFetch: .success(currencyResponse)
        )
        
        let currencyManager = CurrencyManager(networkManager: networkManagerMock)
        
        currencyManager.convertValueWithRate(value: 100, sourceCurrency: .dollar, targetCurrency: .euro) { (result) in
            switch result {
            case .success:
               XCTFail()
            case .failure(let error):
                XCTAssertEqual(error, .failedToGetRatesForConversion)
            
            }
        }
    }
    
    
    func test_givenNormalValue_whenConvertValueWithRate_thenFailedToConvertCorrectFormattedValueAsString() throws {
        
        let currencyResponse = CurrencyResponse(success: true, timestamp: 1606844045, base: "EUR", date: "2020-12-01", rates: ["EUR": 1.1, "USD": 1.0])
        
        let networkManagerMock = NetworkManagerMock(
            resultSuccessType: CurrencyResponse.self,
            resultFetch: .success(currencyResponse)
        )
        
        let currencyManager = CurrencyManager(
            
            networkManager: networkManagerMock,
            numberFormatter: NumberFormatterMock()
        )
        
        currencyManager.convertValueWithRate(value: 110.000, sourceCurrency: .dollar, targetCurrency: .euro) { (result) in
            switch result {
            case .success:
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error, .failedToConvertValue)
            }
        }
    }
   

  
    
}

