//
//  CatchingFireTests.swift
//  CatchingFireTests
//
//  Created by Marius Rackwitz on 7.7.15.
//  Copyright © 2015 Marius Rackwitz. All rights reserved.
//

import XCTest
import CatchingFire

enum Error : ErrorType {
    case MayNotBeZero
}

func failsWithZero(x: Int) throws -> () {
    guard x != 0 else {
        throw Error.MayNotBeZero
    }
}

func idButFailsWithZero(x: Int) throws -> Int {
    guard x != 0 else {
        throw Error.MayNotBeZero
    }
    return x
}

class CatchingFireTests: XCTestCase {
    
    func testVoidDoNotThrow() {
        AssertNotThrow(try failsWithZero(1))
        AssertNotThrow {
            try failsWithZero(1)
        }
    }
    
    func testVoidThrow() {
        AssertThrow(Error.MayNotBeZero, try failsWithZero(0))
        AssertThrow(Error.MayNotBeZero) {
            try failsWithZero(0)
        }
    }
    
    func testNonVoidDoNotThrow() {
        AssertNotThrow(try idButFailsWithZero(1))
        AssertNotThrow {
            let x = try idButFailsWithZero(1)
            XCTAssertEqual(x, 1)
        }
        AssertNotThrow(try idButFailsWithZero(1)).map { (x: Int) in
            XCTAssertEqual(x, 1)
        }
    }
    
    func testNonVoidThrow() {
        AssertThrow(Error.MayNotBeZero, try idButFailsWithZero(0))
        AssertThrow(Error.MayNotBeZero) {
            try idButFailsWithZero(0)
        }
    }
    
}
