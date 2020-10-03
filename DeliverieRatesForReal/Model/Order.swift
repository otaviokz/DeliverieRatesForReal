//
//  Order.swift
//  DeliverieRatesForReal
//
//  Created by Otávio Zabaleta on 03/10/2020.
//

import Foundation

enum OrderError: Error {
    case itemCountError
    case genericError
}

class Order {
    private(set) var items: [Item] = []
    let isPremiumClient: Bool
    
    init(items: [Item] = [], isPremiumClient: Bool = false) throws {
        self.items = items
        self.isPremiumClient = isPremiumClient
        try checkForItemErrors()
    }
    
    func add(_ item: Item) throws {
        items.append(item)
        try checkForItemErrors()
    }
    
    var price: Double {
        var totalPrice: Double = itemsPrice
        
        for rule in PriceRules.orderRules[for: self] {
            totalPrice = rule.calculate(with: totalPrice)
        }
        
        return totalPrice
    }
    
    private var itemsPrice: Double {
        var totalPrice: Double = 0
        
        for item in items {
            totalPrice += PriceRules.itemRules[for: (item, self)].reduce(item.basePrice) {
                $1.calculate(with: $0)
            }
        }
        
        return totalPrice
    }
}

extension Order {
    // Delivery order of up to three items
    private func checkForItemErrors() throws {
        if items.count > 3 {
            throw OrderError.itemCountError
        }
    }
}
