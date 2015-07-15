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
        AssertNoThrow(try failsWithZero(1))
        AssertNoThrow {
            try failsWithZero(1)
        }
    }
    
    func testVoidThrow() {
        AssertThrows(Error.MayNotBeZero, try failsWithZero(0))
        AssertThrows(Error.MayNotBeZero) {
            try failsWithZero(0)
        }
    }
    
    func testNonVoidDoNotThrow() {
        AssertNoThrow(try idButFailsWithZero(1))
        AssertNoThrow {
            let x = try idButFailsWithZero(1)
            XCTAssertEqual(x, 1)
        }
        AssertNoThrow(try idButFailsWithZero(1)).map { (x: Int) in
            XCTAssertEqual(x, 1)
        }
    }
    
    func testNonVoidThrow() {
        AssertThrows(Error.MayNotBeZero, try idButFailsWithZero(0))
        AssertThrows(Error.MayNotBeZero) {
            try idButFailsWithZero(0)
        }
    }
    
}
