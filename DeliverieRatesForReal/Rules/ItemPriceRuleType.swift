//
//  ItemPriceRuleType.swift
//  DeliverieRatesForReal
//
//  Created by Otávio Zabaleta on 03/10/2020.
//

import Foundation

protocol ItemPriceRuleType {
    func applies(to item: Item, in order: Order) -> Bool
    func calculate(with total: Double) -> Double
}

extension Array where Element == ItemPriceRuleType {
    subscript(for tuple: (Item, Order)) -> [ItemPriceRuleType] {
        get {
            filter { $0.applies(to: tuple.0, in: tuple.1) }
        }
    }
}

struct PremiumClientDiscount: ItemPriceRuleType {
    func applies(to item: Item, in order: Order) -> Bool {
        order.isPremiumClient && item.itemType != .largeParcel
    }
    
    func calculate(with total: Double) -> Double {
        let result = total * (1.0 - 0.075)
        print("\(total) * \((1.0 - 0.075)) = \(result)")
        return result
    }
}

extension PriceRules {
    static var itemRules: [ItemPriceRuleType] {
        [
            // Premium clients get a 7.5% discount, except on Large Parcels
            PremiumClientDiscount()
        ]
        
    }
}

