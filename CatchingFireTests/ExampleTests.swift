//
//  ExampleTests.swift
//  CatchingFire
//
//  Created by Marius Rackwitz on 9.7.15.
//  Copyright © 2015 Marius Rackwitz. All rights reserved.
//

import XCTest
import CatchingFire


enum BombError: ErrorType {
    case WrongWire
    case TimeElapsed
}
let 🔥 = BombError.TimeElapsed

let 🕚 = 11
let 🕛 = 12

class Trigger {
    var alarmTime: Int
    private var enabled: Bool = true
    
    init(alarmTime: Int) {
        self.alarmTime = alarmTime
    }
    
    func cutRedWire() throws {
        throw BombError.WrongWire
    }
    
    func cutBlueWire() throws {
        self.enabled = false
    }
    
    func enable() {
        self.enabled = true
    }
}

func 💣(time: Int) throws -> Trigger {
    struct Internals {
        static var trigger = Trigger(alarmTime: 🕛)
    }
    let trigger = Internals.trigger
    if trigger.enabled && time >= trigger.alarmTime {
        throw 🔥
    }
    return trigger
}


class ExampleTests : XCTestCase {

    override func setUp() {
        let trigger = try! 💣(🕚)
        trigger.enable()
    }
    
    func testDisarm() {
        AssertNotThrow {
            let trigger = try 💣(🕚)
            try trigger.cutBlueWire()
        }
        AssertNotThrow(try 💣(🕛))
    }

    func testDoNotDisarm() {
        AssertNotThrow(try 💣(🕚))
        AssertThrow(🔥, try 💣(🕛))
    }

    func testFailToDisarm() {
        AssertThrow(BombError.WrongWire) {
            let trigger = try 💣(🕚)
            try trigger.cutRedWire()
        }
    }
    
    func testIsArmedInitially() {
        XCTAssertTrue(AssertNotThrow(try 💣(🕚))?.enabled == true)
    }
    
}
