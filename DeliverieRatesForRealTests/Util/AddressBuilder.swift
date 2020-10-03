//
//  AddressBuilder.swift
//  DeliverieRatesForRealTests
//
//  Created by Otávio Zabaleta on 03/10/2020.
//

import Foundation
@testable import DeliverieRatesForReal

class AddressBuilder {
    static var highlands: Address {
        return Address(region: "Highlands", city: "Inverness", address: "some address")
    }
    
    static var islands: Address {
        return Address(region: "Islands", city: "Isle of Man", address: "some address")
    }
    
    static var addressOne: Address {
        return Address(region: "Region One", city: "City One", address: "some address")
    }
}
