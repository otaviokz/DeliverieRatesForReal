//
//  OrderTests.swift
//  DeliverieRatesForRealTests
//
//  Created by Otávio Zabaleta on 03/10/2020.
//

import XCTest
@testable import DeliverieRatesForReal

typealias Builder = ItemBuilder

class OrderTests: XCTestCase {
    let sDoc = Builder().doc.same.item
    let tDoc = Builder().doc.three.item
    let sSmall = Builder().small.same.item
    let tSmall = Builder().small.three.item
    let sLarge = Builder().large.same.item
    let tLarge = Builder().large.three.item
    
    func testOrderShouldHaveUpTo_3_Items() throws {
        XCTAssertNoThrow(try Order())
        XCTAssertNoThrow(try Order(items: [sDoc, sSmall, tLarge]))
        XCTAssertThrowsError(try Order(items: [sDoc, sSmall, tLarge, tLarge]))
        
        do {
            _ = try Order(items: [sDoc, sSmall, tLarge, tLarge])
            XCTFail()
        } catch  {
            let orderError = error as? OrderError
            XCTAssertNotNil(orderError)
            XCTAssert(orderError == .itemCountError)
        }
        
        var order = try Order()
        XCTAssertNoThrow(try order.add(tDoc))
        XCTAssertNoThrow(try order.add(sSmall))
        XCTAssertNoThrow(try order.add(sLarge))
        XCTAssertThrowsError(try order.add(sLarge))
        
        do {
            order = try Order(items: [tDoc, sSmall, sLarge])
            try order.add(tSmall)
        } catch {
            let orderError = error as? OrderError
            XCTAssertNotNil(orderError)
            XCTAssert(orderError == .itemCountError)
        }
    }
    
    func testcalculatePrice() throws {
        XCTAssertEqual(try Order(items: [sDoc, sSmall, tLarge]).price, 4 + 7 + 3)

        XCTAssertEqual(try Order(items: [sDoc, sSmall, sLarge]).price, (4 + 7 + 9) * 0.95)
        
        let order = try Order(items: [tDoc, tLarge, tSmall], isPremiumClient: true)
        XCTAssertEqual(order.price, ((1 + 2.5) * 0.925) + 3, accuracy: 0.001)
    }
}
