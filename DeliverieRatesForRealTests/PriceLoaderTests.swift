//
//  PriceLoaderTests.swift
//  DeliverieRatesForRealTests
//
//  Created by Otávio Zabaleta on 03/10/2020.
//

import XCTest
@testable import DeliverieRatesForReal

class PriceLoaderTests: XCTestCase {

    func testJSONPriceLoader() throws {
        let loader = PriceLoader.shared
        XCTAssert(loader.price(for: .document, in: .sameDay) == 4)
        XCTAssert(loader.price(for: .document, in: .threeDays) == 1)
        XCTAssert(loader.price(for: .smallParcel, in: .sameDay) == 7)
        XCTAssert(loader.price(for: .smallParcel, in: .threeDays) == 2.5)
        XCTAssert(loader.price(for: .largeParcel, in: .sameDay) == 9)
        XCTAssert(loader.price(for: .largeParcel, in: .threeDays) == 3)
        XCTAssertNil(loader.price(for: .largeParcel, in: .invalid))
        XCTAssertNil(loader.price(for: .invalid, in: .sameDay))
        XCTAssertNil(loader.price(for: .invalid, in: .invalid))
    }
}
