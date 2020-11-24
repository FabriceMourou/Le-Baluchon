import XCTest
@testable import Le_Baluchon

class CurrencyManagerTests: XCTestCase {
    
    
    private var currencyManager: CurrencyManager!
    
    
    override func setUp() {
        super.setUp()
        currencyManager = CurrencyManager()
    }
    
    

    func test_getFormattedTemperature_givenValid() throws {
        let networkManagerMock = AlwaysFailNetworkManagerMock()
        let currencyManager = CurrencyManager(networkManager: networkManagerMock)
        
        currencyManager.convertValueWithRate(value: 100, sourceCurrency: .dollar, targetCurrency: .euro) { (result) in
            switch result {
            case .success:
                XCTFail()
            case .failure:
                XCTAssert(true)
            }
        }
    }
    
    
    func test_getFormattedTemperature_givenValidessSucc() throws {
        let networkManagerMock = CurrencySuccessNetworkManagerMock()
        let currencyManager = CurrencyManager(networkManager: networkManagerMock)
        
        currencyManager.convertValueWithRate(value: 100, sourceCurrency: .dollar, targetCurrency: .euro) { (result) in
            switch result {
            case .success:
                XCTAssert(true)
            case .failure:
               XCTFail()
            }
        }
    }
   
    
}

