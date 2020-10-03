//
//  DeliveryItem.swift
//  DeliverieRatesForReal
//
//  Created by Otávio Zabaleta on 03/10/2020.
//

import Foundation

enum ItemType: String, Codable {
    case document
    case smallParcel
    case largeParcel
    case invalid
    
    init(rawValue: String) {
        switch rawValue.lowercased().trimmingCharacters(in: CharacterSet(charactersIn: " ")) {
        case ItemType.document.rawValue.lowercased():
            self = .document
        case ItemType.smallParcel.rawValue.lowercased():
            self = .smallParcel
        case ItemType.largeParcel.rawValue.lowercased():
            self = .largeParcel
        default:
            self = .invalid
        }
    }
}

enum DeliveryType: String, Codable {
    case sameDay
    case threeDays
    case invalid
    
    init(rawValue: String) {
        switch rawValue.lowercased().trimmingCharacters(in: CharacterSet(charactersIn: " ")) {
        case DeliveryType.sameDay.rawValue.lowercased():
            self = .sameDay
        case DeliveryType.threeDays.rawValue.lowercased():
            self = .threeDays
        default:
            self = .invalid
        }
    }
}
