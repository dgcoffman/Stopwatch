import XCTest

class UITests: XCTestCase {
    override func setUp() {
        let app = XCUIApplication()
        app.launch()
    }

    func testStopwatchStartLapStopResetFlow() {
        let app = XCUIApplication()
        let startStopButton = app.buttons["startStopButton"]
        let lapButton = app.buttons["lapButton"]
        let resetButton = app.buttons["resetButton"]
        let timeLabel = app.staticTexts["elapsedTimeDisplay"]

        // Verify initial state
        XCTAssertEqual(startStopButton.label, "Start")
        XCTAssertEqual(timeLabel.label, "00:00:00")

        // Start the clock
        startStopButton.tap()

        // The button should now say "Stop"
        XCTAssertEqual(startStopButton.label, "Stop")

        // Record a lap
        lapButton.tap()

        // Verify it made a row saying "Lap 1"
        let lapTableRow = app.tables.cells.staticTexts["Lap 1"]
        XCTAssertTrue(lapTableRow.waitForExistence(timeout: 1))

        // Stop the clock
        startStopButton.tap()

        // Verify the button says "Start" again
        XCTAssertEqual(startStopButton.label, "Start")

        // Verify that the time is no longer zero
        XCTAssertNotEqual(timeLabel.label, "00:00:00")

        // Reset the clock
        resetButton.tap()

        // Now the time should be zero again
        XCTAssertEqual(timeLabel.label, "00:00:00")
    }
}
