//
//  DogTests.swift
//  DogTests
//
//  Created by fernando babonoyaba on 11/12/23.
//

import XCTest
@testable import Dog

final class DogTests: XCTestCase {

    var soundModel: SoundModel?
    let soundController: SoundController = SoundController()

    override func setUpWithError() throws {
        super.setUp()
        soundModel = SoundModel(volume: 0.25, hertz: 5000, isSelected: true, buttonAnimation: true)// Assuming a default initializer
    }

    override func tearDownWithError() throws {
        soundModel = nil
        super.tearDown()
    }


    func testInitialization() {
        XCTAssertNotNil(soundModel, "SoundModel should not be nil upon initialization")
        // Add more assertions here based on the default state of your model
    }

    func testPropertyChange() {
        // Example property test
        XCTAssertEqual(soundModel?.hertz, 5000, "Property did not update correctly")
    }
    
    func testResetOnRotation() {
        soundController.soundModel.buttonAnimation = true
        soundController.resetOnRotation()

        XCTAssertFalse(soundController.soundModel.buttonAnimation)
    }

    func testStart() {
        // Assuming a method that changes state or performs calculations
//        let result = soundModel.performCalculation()
        soundController.startTone()

        XCTAssertTrue(soundController.soundModel.buttonAnimation)
    }
    
    func testStop() {
        soundController.stopTone()

        XCTAssertFalse(soundController.soundModel.buttonAnimation)
    }
    
    func testToggleContinuous() {

        soundController.soundModel.isSelected = true
        soundController.soundModel.buttonAnimation = true

        soundController.toggleContinuous()

        XCTAssertFalse(soundController.soundModel.isSelected)
        XCTAssertFalse(soundController.soundModel.buttonAnimation)

    }

}
