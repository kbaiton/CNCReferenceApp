//
//  CalculatorViewModelTests.swift
//  CalculatorViewModelTests
//
//  Created by Kale Baiton on 2017-07-23.
//  Copyright © 2017 Kale Baiton. All rights reserved.
//

import XCTest
@testable import CNCReferenceApp

class CalculatorViewModelTests: XCTestCase {
    
    var sut: CalculatorViewModel!
    
    override func setUp() {
        super.setUp()
        sut = CalculatorViewModel()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        super.tearDown()
    }
    
    func testCalculatorCellsInitalizedProperly() {
        XCTAssert(sut.cellModels.array.contains(where: { $0.type == .bitDiameter }))
        XCTAssert(sut.cellModels.array.contains(where: { $0.type == .spindleSpeed }))
        XCTAssert(sut.cellModels.array.contains(where: { $0.type == .flutes }))
        XCTAssert(sut.cellModels.array.contains(where: { $0.type == .chipLoad }))
        XCTAssert(sut.cellModels.array.contains(where: { $0.type == .feedRate }))
    }
    
    func testGetModelOfType() {
        XCTAssert(sut.getModelWithType(.bitDiameter)?.type == .bitDiameter)
        XCTAssert(sut.getModelWithType(.spindleSpeed)?.type == .spindleSpeed)
        XCTAssert(sut.getModelWithType(.flutes)?.type == .flutes)
        XCTAssert(sut.getModelWithType(.chipLoad)?.type == .chipLoad)
        XCTAssert(sut.getModelWithType(.feedRate)?.type == .feedRate)
    }
    
}
