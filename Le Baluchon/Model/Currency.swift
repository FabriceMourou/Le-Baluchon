//
//  Currency.swift
//  Le Baluchon
//
//  Created by Fabrice Mourou on 20/10/2020.
//

import Foundation


enum Currency {
    case dollar, euro
    
    
    var symbol: String {
        switch self {
        case .dollar: return "$"
        case .euro: return "€"
        }
    }
    
    var code: String {
        switch self {
        case .dollar: return "USD"
        case .euro: return "EUR"
        }
    }
}
