//
//  ItemBuilder.swift
//  DeliverieRatesForRealTests
//
//  Created by Otávio Zabaleta on 03/10/2020.
//

import Foundation
@testable import DeliverieRatesForReal

class ItemBuilder {
    private var itemType: ItemType = .document
    private var deliveryType: DeliveryType = .sameDay
    private var priceLoader: PriceLoaderType = PriceLoader.shared
    private var toAddress: Address = AddressBuilder.addressOne
    
    @inlinable var same: ItemBuilder {
        deliveryType = .sameDay
        return self
    }
    
    @inlinable var three: ItemBuilder {
        deliveryType = .threeDays
        return self
    }
    
    @inlinable var doc: ItemBuilder {
        itemType = .document
        return self
    }
    
    @inlinable var small: ItemBuilder {
        itemType = .smallParcel
        return self
    }
    
    @inlinable var large: ItemBuilder {
        itemType = .largeParcel
        return self
    }
    
    @inlinable var highLands: ItemBuilder {
        toAddress = AddressBuilder.highlands
        return self
    }
    
    @inlinable var addressOne: ItemBuilder {
        toAddress = AddressBuilder.addressOne
        return self
    }
    
    var item: Item {
        Item(itemType: itemType, deliveryType: deliveryType, toAddress: toAddress, priceLoader: priceLoader)
    }
}
