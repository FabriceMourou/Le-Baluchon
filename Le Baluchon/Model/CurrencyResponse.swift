//
//  CurrencyResponse.swift
//  Le Baluchon
//
//  Created by Fabrice Mourou on 27/10/2020.
//

import Foundation

// MARK: - CurrencyResponse
struct CurrencyResponse: Codable {
    let success: Bool
    let timestamp: Int
    let base, date: String
    let rates: [String: Double]
}

