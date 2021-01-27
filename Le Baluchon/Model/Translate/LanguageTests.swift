
@testable import Le_Baluchon

import XCTest

class LanguagesTests: XCTestCase {
    
    
    func testGivenDutchLanguageWhenGetTitleThenProvideCorrectInfo() {
        let dutchLanguage = Language.dutch
        
        let title = dutchLanguage.title
        
        XCTAssertEqual(title, "Dutch")
    }
    
    func testGivenEnglishLanguageWhenGetTitleThenProvideCorrectInfo() {
        let englishLanguage = Language.english
        
        let title = englishLanguage.title
        
        XCTAssertEqual(title, "English")
    }
    
    func testGivenFrenchLanguageWhenGetTitleThenProvideCorrectInfo() {
        let frenchLanguage = Language.french
        
        let title = frenchLanguage.title
        
        XCTAssertEqual(title, "French")
    }
    
    
    func testGivenGermanLanguageWhenGetTitleThenProvideCorrectInfo() {
        let germanLanguage = Language.german
        
        let title = germanLanguage.title
        
        XCTAssertEqual(title, "German")
    }
    
    func testGivenPortugeseLanguageWhenGetTitleThenProvideCorrectInfo() {
        let portugeseLanguage = Language.portuguese
        
        let title = portugeseLanguage.title
        
        XCTAssertEqual(title, "Portugese")
    }
    
    func testGivenSpanishLanguageWhenGetTitleThenProvideCorrectInfo() {
        let spanishLanguage = Language.spanish
        
        let title = spanishLanguage.title
        
        XCTAssertEqual(title, "Spanish")
    }
    
    
    
    func testGivenDutchLanguageWhenGetCodeThenProvideCorrectInfo() {
        let dutchLanguage = Language.dutch
        
        let title = dutchLanguage.code
        
        XCTAssertEqual(title, "nl")
    }
    
    func testGivenEnglishLanguageWhenGetCodeThenProvideCorrectInfo() {
        let englishLanguage = Language.english
        
        let title = englishLanguage.code
        
        XCTAssertEqual(title, "en")
    }
    
    func testGivenFrenchLanguageWhenGetCodeThenProvideCorrectInfo() {
        let frenchLanguage = Language.french
        
        let title = frenchLanguage.code
        
        XCTAssertEqual(title, "fr")
    }
    
    
    func testGivenGermanLanguageWhenGetCodeThenProvideCorrectInfo() {
        let germanLanguage = Language.german
        
        let title = germanLanguage.code
        
        XCTAssertEqual(title, "de")
    }
    
    func testGivenPortugeseLanguageWhenGetCodeThenProvideCorrectInfo() {
        let portugeseLanguage = Language.portuguese
        
        let title = portugeseLanguage.code
        
        XCTAssertEqual(title, "pt")
    }
    
    func testGivenSpanishLanguageWhenGetCodeThenProvideCorrectInfo() {
        let spanishLanguage = Language.spanish
        
        let title = spanishLanguage.code
        
        XCTAssertEqual(title, "es")
    }
    
    
    
    
    
    
    
}

