//
//  OrderValidationRuleType.swift
//  DeliverieRatesForReal
//
//  Created by Otávio Zabaleta on 03/10/2020.
//

import Foundation

protocol StringHashable {
    var stringHash: String { get }
}

enum ItemValidationError: Error, StringHashable {
    case deliveryTypeInvalidRegion(_ type: DeliveryType, address: Address)
    case generic(error: String?)
    
    var stringHash: String {
        switch self {
        case .deliveryTypeInvalidRegion(let type, let address):
            return "deliveryTypeInvalidRegion(\(type.rawValue), \(address.stringHash)"
        case .generic(let error):
            return "generic(\(error ?? "nil"))"
        }
    }
}

enum ItemValidationResult: Equatable, StringHashable {
    case invalid(error: ItemValidationError)
    case valid
    
    static func == (lhs: ItemValidationResult, rhs: ItemValidationResult) -> Bool {
        lhs.stringHash.lowercased() == rhs.stringHash.lowercased()
    }
    
    var stringHash: String {
        switch self {
        case .valid:
            return "valid"
        case .invalid(let error):
            return "invalid(\(error.stringHash)"
        }
    }
}

protocol ItemValidationRuleType {
    func validate(_ item: Item) -> Bool
    func error(for item: Item) -> ItemValidationResult
}

struct DeliveryTypeUnavailableInRegion: ItemValidationRuleType {
    let deliveryType: DeliveryType
    let region: String
    
    func validate(_ item: Item) -> Bool {
        !item.toAddress.contains(region: region)
    }
    
    func error(for item: Item) -> ItemValidationResult {
        .invalid(error: .deliveryTypeInvalidRegion(deliveryType, address: item.toAddress))
    }
}


