//
//  TinyTimerTests.swift
//  TinyTimerTests
//
//  Created by Tri Nguyen on 9/4/19.
//  Copyright © 2019 Tri Nguyen. All rights reserved.
//

import XCTest
@testable import TinyTimer

class TinyTimerTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testconvertTicksToTime() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual("00:10", TimeUtils.convertTicksToTime(ticks: 10))
        XCTAssertEqual("00:20", TimeUtils.convertTicksToTime(ticks:20))
        XCTAssertEqual("00:05", TimeUtils.convertTicksToTime(ticks:5))
        XCTAssertEqual("01:00", TimeUtils.convertTicksToTime(ticks:60))
        XCTAssertEqual("02:00", TimeUtils.convertTicksToTime(ticks:120))
        XCTAssertEqual("01:59", TimeUtils.convertTicksToTime(ticks:119))
        XCTAssertEqual("01:00:00", TimeUtils.convertTicksToTime(ticks:1 * 60 * 60))
        XCTAssertEqual("01:01:00", TimeUtils.convertTicksToTime(ticks:1 * 60 * 60 + 60))
        XCTAssertEqual("02:00:00", TimeUtils.convertTicksToTime(ticks:2 * 60 * 60))
        XCTAssertEqual("04:00:00", TimeUtils.convertTicksToTime(ticks:4 * 60 * 60))
    }
    func testconvertTicksToMenu() {
        XCTAssertEqual("0 second", TimeUtils.convertTicksToMenu(ticks: 0))
        XCTAssertEqual("1 second", TimeUtils.convertTicksToMenu(ticks: 1))
        XCTAssertEqual("10 seconds", TimeUtils.convertTicksToMenu(ticks: 10))
        XCTAssertEqual("20 seconds", TimeUtils.convertTicksToMenu(ticks: 20))
        XCTAssertEqual("1 minute", TimeUtils.convertTicksToMenu(ticks: 60))
        XCTAssertEqual("2 minutes", TimeUtils.convertTicksToMenu(ticks: 120))
        XCTAssertEqual("1 minute 59 seconds", TimeUtils.convertTicksToMenu(ticks: 119))
        XCTAssertEqual("1 hour", TimeUtils.convertTicksToMenu(ticks: 1 * 60 * 60))
        XCTAssertEqual("1 hour 1 minute", TimeUtils.convertTicksToMenu(ticks: 1 * 60 * 60 + 60))
        XCTAssertEqual("2 hours", TimeUtils.convertTicksToMenu(ticks: 2 * 60 * 60))
        XCTAssertEqual("4 hours", TimeUtils.convertTicksToMenu(ticks: 4 * 60 * 60))
    }

}
