//
//  ItemTypeTests.swift
//  DeliverieRatesForRealTests
//
//  Created by Otávio Zabaleta on 03/10/2020.
//

import XCTest
@testable import DeliverieRatesForReal

class DeliveryItemTests: XCTestCase {

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
}
