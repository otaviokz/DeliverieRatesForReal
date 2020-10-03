//
//  PriceRules.swift
//  DeliverieRatesForReal
//
//  Created by Otávio Zabaleta on 03/10/2020.
//

import Foundation

struct PriceRules {
    static var orderRules: [OrderPriceRuleType] {
        [
            // An order with 3 Same Day items gets a 5% discount
            ThreeSameDayItemsDiscount()
        ]
    }

    static var itemRules: [ItemPriceRuleType] {
        [
            // Premium clients get a 7.5% discount, except on Large Parcels
            PremiumClientDiscount()
        ]
        
    }
}

struct ValidationRules {
    static var itemRules: [ItemValidationRuleType] {
        [
            DeliveryTypeUnavailableInRegion(deliveryType: .sameDay, region: "Highlands"),
            DeliveryTypeUnavailableInRegion(deliveryType: .sameDay, region: "Islands")
        ]
    }
}
