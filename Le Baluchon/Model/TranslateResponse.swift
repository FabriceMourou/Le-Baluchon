

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let translateResponse = try? newJSONDecoder().decode(TranslateResponse.self, from: jsonData)

import Foundation


// MARK: - TranslateResponse
struct TranslateResponse: Codable {
    let data: DataClass?
}

// MARK: - DataClass
struct DataClass: Codable {
    let languages: [Language]?
}

// MARK: - Language
struct Language: Codable {
    let language: String?
}
