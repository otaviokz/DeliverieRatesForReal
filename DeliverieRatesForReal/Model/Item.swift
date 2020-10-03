//
//  Item.swift
//  DeliverieRatesForReal
//
//  Created by Otávio Zabaleta on 03/10/2020.
//

import Foundation

enum ItemType: String {
    case document
    case smallParcel
    case largeParcel
    case invalid
}

enum DeliveryType: String {
    case sameDay
    case threeDays
    case invalid
}

struct Item {
    let itemType: ItemType
    let deliveryType: DeliveryType
    let priceLoader: PriceLoaderType
    let toAddress: Address
    
    init(itemType: ItemType,
         deliveryType: DeliveryType,
         toAddress: Address,
         priceLoader: PriceLoaderType = PriceLoader.shared) {
        self.itemType = itemType
        self.deliveryType = deliveryType
        self.toAddress = toAddress
        self.priceLoader = priceLoader
    }
    
    init(_ itemType: ItemType, in deliveryType: DeliveryType, toAddress: Address, priceLoader: PriceLoaderType = PriceLoader.shared) {
        self.init(itemType: itemType, deliveryType: deliveryType, toAddress: toAddress, priceLoader: priceLoader)
    }
    
    var basePrice: Double {
        return priceLoader.price(for: itemType, in: deliveryType) ?? 0
    }
    
    var validate: ItemValidationResult {
        ValidationRules.itemRules.first(where: { !$0.validate(self) })?.error(for: self) ?? .valid
    }
}

extension Array where Element == Item {
    var sameDayItems: [Element] {
        filter { $0.deliveryType == .sameDay }
    }
}
