//
//  ItemTypeTests.swift
//  DeliverieRatesForRealTests
//
//  Created by Otávio Zabaleta on 03/10/2020.
//

import XCTest
@testable import DeliverieRatesForReal

class ItemTests: XCTestCase {

    func testItemType() throws {
        XCTAssert(ItemType(rawValue: "dOcUmEnT") == .document)
        XCTAssert(ItemType(rawValue: "smallParcel") == .smallParcel)
        XCTAssert(ItemType(rawValue: " largeParcel ") == .largeParcel)
        XCTAssert(ItemType(rawValue: " largeParcel l") == .invalid)
    }
    
    func testDeliveryType() throws {
        XCTAssert(DeliveryType(rawValue: "SAMEDAY") == .sameDay)
        XCTAssert(DeliveryType(rawValue: "tHrEeDaYs") == .threeDays)
        XCTAssert(DeliveryType(rawValue: "document") == .invalid)
    }
    
    func testItemValidation() throws {
        let valid = Item(.smallParcel, in: .threeDays, toAddress: AddressBuilder.addressOne)
        XCTAssert(valid.validate == .valid)
        
        let regionInvalid = Item(.smallParcel, in: .sameDay, toAddress: AddressBuilder.highlands)
        XCTAssert(regionInvalid.validate == .invalid(error: .deliveryTypeInvalidRegion(.sameDay, address: AddressBuilder.highlands)))
    }
}


