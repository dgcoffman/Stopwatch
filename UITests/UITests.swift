import XCTest

// https://www.hackingwithswift.com/articles/83/how-to-test-your-user-interface-using-xcode
// https://www.hackingwithswift.com/articles/148/xcode-ui-testing-cheat-sheet

class UITests: XCTestCase {
    override func setUp() {
        continueAfterFailure = false

        let app = XCUIApplication()

        [].map({ } )

        // We pass a launch argument that can be read by the running app:
        //
        // #if DEBUG
        // if CommandLine.arguments.contains("enable-testing") {
        //   configureTestingState()
        // }
        // #endif
        app.launchArguments = ["enable-testing"]
        app.launch()
    }

    func testExample() {
        let app = XCUIApplication()

        let startButton = app.buttons["Start"]
        startButton.tap()

        let stopButton = app.buttons["Stop"]
        stopButton.tap()

        let lapButton = app.buttons["Lap"]
        lapButton.tap()

        stopButton.tap()
        app.buttons["Reset"].tap()

        

    }
}
