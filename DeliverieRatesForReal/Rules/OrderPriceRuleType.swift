//
//  OrderPriceRule.swift
//  DeliverieRatesForReal
//
//  Created by Otávio Zabaleta on 03/10/2020.
//

import Foundation

protocol OrderPriceRuleType {
    func applies(to order: Order) -> Bool
    func calculate(with total: Double) -> Double
}

extension Array where Element == OrderPriceRuleType {
    subscript(for order: Order) -> [OrderPriceRuleType] {
        get {
            filter { $0.applies(to: order) }
        }
    }
}

struct ThreeSameDayItemsDiscount: OrderPriceRuleType {
    func applies(to order: Order) -> Bool {
        order.items.sameDayItems.count == 3
    }
    
    func calculate(with total: Double) -> Double {
        total * (1 - 0.05)
    }
}
