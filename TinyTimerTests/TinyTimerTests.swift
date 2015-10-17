//
//  TinyTimerTests.swift
//  TinyTimerTests
//
//  Created by User on 10/17/15.
//  Copyright © 2015 Tri Nguyen. All rights reserved.
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
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual("00:10", TimeUtils.convertTicksToTime(10))
        XCTAssertEqual("00:20", TimeUtils.convertTicksToTime(20))
        XCTAssertEqual("00:05", TimeUtils.convertTicksToTime(5))
        XCTAssertEqual("01:00", TimeUtils.convertTicksToTime(60))
        XCTAssertEqual("02:00", TimeUtils.convertTicksToTime(120))
        XCTAssertEqual("01:59", TimeUtils.convertTicksToTime(119))
        XCTAssertEqual("01:00:00", TimeUtils.convertTicksToTime(1 * 60 * 60))
        XCTAssertEqual("01:01:00", TimeUtils.convertTicksToTime(1 * 60 * 60 + 60))
        XCTAssertEqual("02:00:00", TimeUtils.convertTicksToTime(2 * 60 * 60))
        XCTAssertEqual("04:00:00", TimeUtils.convertTicksToTime(4 * 60 * 60))
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
