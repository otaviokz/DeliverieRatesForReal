//
//  Address.swift
//  DeliverieRatesForReal
//
//  Created by Otávio Zabaleta on 03/10/2020.
//

import Foundation

struct Address: StringHashable {
    let region: String
    let city: String
    let address: String
    
    func contains(region someRegion: String) -> Bool {
        region.lowercased() == someRegion.lowercased()
    }
    
    var stringHash: String {
        return "\(region + city + address)"
    }
}
