@testable import Le_Baluchon

import XCTest

class CurrencyTests: XCTestCase {
    
    
    func testGivenEuroCurrencyWhenGetSymbolThenProvideCorrectInfo() {
        let euroCurrency = Currency.euro
        
        let symbol = euroCurrency.symbol
        
        XCTAssertEqual(symbol, "€")
    }
    
    
    func testGivenDollarCurrencyWhenGetSymbolThenProvideCorrectInfo() {
        let dollarCurrency = Currency.dollar
        
        let symbol = dollarCurrency.symbol
        
        XCTAssertEqual(symbol, "$")
    }
    
    
    func testGivenEuroCurrencyWhenGetCodeThenProvideCorrectInfo() {
        let euroCurrency = Currency.euro
        
        let symbol = euroCurrency.code
        
        XCTAssertEqual(symbol, "EUR")
    }
    
    
    func testGivenDollarCurrencyWhenGetCodeThenProvideCorrectInfo() {
        let dollarCurrency = Currency.dollar
        
        let symbol = dollarCurrency.code
        
        XCTAssertEqual(symbol, "USD")
    }
    
    
    
    
}
