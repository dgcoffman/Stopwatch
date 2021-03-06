
// This file contains the fastlane.tools configuration
// You can find the documentation at https://docs.fastlane.tools
//
// For a list of all available actions, check out
//
//     https://docs.fastlane.tools/actions
//

import Foundation

class Fastfile: LaneFile {
    func screenshotsLane() {
        desc("Generate new localized screenshots")
        captureScreenshots(workspace: "StopwatchApp.xcworkspace", scheme: "UITests")
        uploadToAppStore(username: "dgcoffman@gmail.com", skipBinaryUpload: true, app: "dgc.Stopwatch")
    }

    func releaseLane(withOptions options: [String: String]?) {
        syncCodeSigning(
            type: "appstore",
            appIdentifier: ["dgc.Stopwatch"],
            username: "dgcoffman@gmail.com",
            gitUrl: "https://github.com/dgcoffman/Stopwatch"
        )
        incrementBuildNumber(buildNumber: options?["build_number"])
        buildApp(scheme: "Stopwatch")
        uploadToAppStore(username: "dgcoffman@gmail.com", app: "dgc.Stopwatch")
    }
}
