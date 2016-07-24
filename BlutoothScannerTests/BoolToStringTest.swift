//
//  BlutoothScannerTests.swift
//  BlutoothScannerTests
//
//  Created by Benjamin Dumont on 15/07/2016.
//  Copyright © 2016 Bdumont. All rights reserved.
//

import XCTest
@testable import BlutoothScanner

class BoolToStringTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testBoolToString() {
        XCTAssertTrue(true.toString() == "YES")
        XCTAssertTrue(false.toString() == "NO")
    }
}
