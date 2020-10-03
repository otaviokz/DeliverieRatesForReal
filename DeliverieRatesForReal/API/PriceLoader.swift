//
//  PriceLoader.swift
//  DeliverieRatesForReal
//
//  Created by Otávio Zabaleta on 03/10/2020.
//

import Foundation

protocol PriceLoaderType {
    static var shared: PriceLoaderType { get }
    func price(for itemType: ItemType, in deliveryType: DeliveryType) -> Double?
}

struct ItemPrice: Codable {
    let itemType: ItemType
    let deliveryType: DeliveryType
    let price: Double
    
    private enum CodingKeys: String, CodingKey {
        case itemType
        case deliveryType
        case price
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ItemPrice.CodingKeys.self)
        itemType = try container.decodeIfPresent(ItemType.self, forKey: .itemType) ?? .invalid
        deliveryType = try container.decodeIfPresent(DeliveryType.self, forKey: .deliveryType) ?? .invalid
        price = try container.decodeIfPresent(Double.self, forKey: .price) ?? 0
    }
}

class PriceLoader: PriceLoaderType {
    static let shared: PriceLoaderType = PriceLoader()
    
    let filePath: String
    private var itemPrices: [ItemPrice] = []
    
    init(filePath: String = "sampleData.json") {
        self.filePath = filePath
        itemPrices = DataUtils.loadJson(filePath)
    }
    
    func price(for itemType: ItemType, in deliveryType: DeliveryType) -> Double? {
        let itemPrice = itemPrices.first { criteria in
            criteria.itemType == itemType && criteria.deliveryType == deliveryType
        }
        return itemPrice?.price
    }
}
