
# Stopwatch
The world's most over-engineered stopwatch app for iOS.

I'm learning:
- Swift
- UIKit
- SwiftLint
- SwiftFormat
- CocoaPods
- Swift unit testing with Quick and Nimble
- SnapKit
- xcodebuild
- ~~xcpretty~~ xcbeautify
- CircleCI for iOS builds

___

***What's happening here?***

**Formatting code**

Execute `Scripts/format` to run [SwiftFormat](https://github.com/nicklockwood/SwiftFormat/) and [SwiftLint](https://github.com/realm/SwiftLint) autocorrect.

**Linters**

Execute `Scripts/lint` to verify that SwiftFormat would produce no code changes, and that code is compliant with SwiftLint rules.

**Unit tests**

Execute `Scripts/unittest` to run unit tests.

Unit tests are written with [Quick](https://github.com/Quick/Quick), a BDD-style testing framework that will look familiar to users of Jasmine or Jest. 

Quick comes with [Nimble](https://github.com/Quick/Nimble), a set of test matchers.

**UI Tests**

Execute `Scripts/uitest` to run UI tests.

**Continuous Integration**

CircleCI [![CircleCI](https://circleci.com/gh/dgcoffman/Stopwatch/tree/master.svg?style=svg)](https://circleci.com/gh/dgcoffman/Stopwatch/tree/master) runs four jobs in parallel:

- SwiftFormat: Verifies that running SwiftFormat would introduce no changes (so the code has already been formatted correctly).
- SwiftLint: Verifies that the code is compliant with SwiftLint rules.
- UnitTest: Verifies that the unit tests pass.
- UITest: Verifies that UI tests pass.

UnitTest and UITest both use `xcodebuild test`, with [xcbeautify](https://github.com/thii/xcbeautify) to produce attractive, human-readable output. The human-readable output is _not_ used to to inform CircleCI of test results -- intead [trainer](https://github.com/xcpretty/trainer) produces a JUnit formatted XML file from the TestSummaries.plist file that `xcodebuild test` produces. 
