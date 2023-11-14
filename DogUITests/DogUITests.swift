//
//  DogUITests.swift
//  DogUITests
//
//  Created by fernando babonoyaba on 11/13/23.
//

import XCTest

final class DogUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }



    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
        XCUIDevice.shared.orientation = .portrait // or .landscapeRight

    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func testLandscapeOrientation() {
        let app = XCUIApplication()
        XCUIDevice.shared.orientation = .landscapeLeft // or .landscapeRight

        // Add steps to interact with the UI
        app.buttons["SoundButton"].tap()

        // Add assertions to verify the UI is in the expected state
//       XCTAssertEqual(app.staticTexts.element(matching: .any, identifier: "YourLabelIdentifier").label, "Expected Label Text")
    }

    
}
