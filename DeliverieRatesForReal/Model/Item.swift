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
    
    init(itemType: ItemType, deliveryType: DeliveryType, priceLoader: PriceLoaderType = PriceLoader.shared) {
        self.itemType = itemType
        self.deliveryType = deliveryType
        self.priceLoader = priceLoader
    }
    
    init(_ itemType: ItemType, in deliveryType: DeliveryType, priceLoader: PriceLoaderType = PriceLoader.shared) {
        self.init(itemType: itemType, deliveryType: deliveryType, priceLoader: priceLoader)
    }
    
    var basePrice: Double {
        return priceLoader.price(for: itemType, in: deliveryType) ?? 0
    }
}


extension Array where Element == Item {
    var sameDayItems: [Element] {
        filter { $0.deliveryType == .sameDay }
    }
}
