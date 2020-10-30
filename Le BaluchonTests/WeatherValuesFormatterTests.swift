//
//  Le_BaluchonTests.swift
//  Le BaluchonTests
//
//  Created by Fabrice Mourou on 05/10/2020.
//

import XCTest
@testable import Le_Baluchon

class WeatherValuesFormatterTests: XCTestCase {
    
    
    private var weatherValuesFormatter: WeatherValuesFormatter!
    
    
    override func setUp() {
        super.setUp()
        weatherValuesFormatter = WeatherValuesFormatter()
    }
    
    

    func test_getFormattedTemperature_givenValid() throws {
        let formattedTemperature = weatherValuesFormatter.getFormattedTemperature(from: 10.523)
        XCTAssertEqual(formattedTemperature, "11°C")
    }
    
    
    func test_getFormattedTemperature_givenValidasdasd() throws {
        let formattedTemperature = weatherValuesFormatter.getFormattedTemperature(from: 10.400)
        XCTAssertEqual(formattedTemperature, "10°C")
    }
    
    func test_getFormattedTemperature_givenValidasdassaddasd() throws {
        let formattedTemperature = weatherValuesFormatter.getFormattedTemperature(from: 10.5)
        XCTAssertEqual(formattedTemperature, "10°C")
    }
    
    
}
