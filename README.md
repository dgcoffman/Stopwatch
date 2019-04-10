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

---

**_What's happening here?_**

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

**Things I tried but didn't go with**

1. I tried adding danger-swift and it didn't work https://github.com/danger/swift/issues/221 at all
2. I tried running tests with xctool and got it half-working (it ran the unit, but not UI tests), but ultimately that failed https://github.com/facebook/xctool/issues/764
3. I started with NSLayoutAnchor, then [switched to SnapKit](https://github.com/dgcoffman/Stopwatch/commit/dda9c8a2d9df7852df6f6fac6d3c5ac9608bfdfb#diff-53648d015562678943c6c6c74fb4e321L113). This was a mistake. NSLayoutAnchor is fine.
4. I used xcpretty for a while, then switched to using xcbeautify for xcodebuild human-readability
5. I tried running formatters (SwiftFormat, Swimat) in Xcode, but it didn't work well because Xcode _does not support_ format-on-save. SwiftFormat has a method to let you hack around this, but it overwrites your whole file, clobbering your undo stack. In the end, I settled on only running SwiftFormat manually with a script I wrote (Scripts/format).
6. I tried to bring in Komondor to add a pre-commit git hook to run SwiftFormat, but decided it was gross and people can make their own from the instructions at https://github.com/nicklockwood/SwiftFormat/#git-pre-commit-hook
7. I started out running `pod install` in CI, and it took FOREVER, so I figured out how to [fetch CocoaPods Specs from CircleCI's S3 bucket](https://github.com/dgcoffman/Stopwatch/commit/85d26add617461f3732f1613dcd2354aa60e78ff). But in the end, I just checked in all my pods and stopped running `pod install` entirely!
8. If you `brew install` something in a Circle job, Homebrew will try to update itself first! You can disable that to save time: https://github.com/dgcoffman/Stopwatch/commit/3dce2977c58acba7bc03515dd7c1c978a5b47b73
9. I tried making an entirely distinct target and scheme specifically to disable warnings from the Swift compiler for CI builds -- but it didn't work at all!! So I removed it. https://github.com/dgcoffman/Stopwatch/commit/7fd60cc82cb3d2db87ce1ac389b43aaf8589a2cf
10. I tried using xcpretty to JUnit format the xcodebuild output to produce a test report that Circle can read, but ultimately went with trainer for producing machine-readable JUnit-formatted XML. I think this is better.

**Other stuff I figured out**

1. xcodebuild insists on writing warnings to stderr, which makes them show up in Circle's output. Also Swift code in pods produce _a lot_ of errors. You can supress them: https://github.com/dgcoffman/Stopwatch/commit/e6f1aad14b0cba591f7cda9c47ce813a0a624351#diff-4a25b996826623c4a3a4910f47f10c30R6
2. Running `pod install` produces 2 warnings for each target by default. Something about a conflict with the project setting ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES. You can mark the project setting as \$(inherited) to fix this. https://github.com/dgcoffman/Stopwatch/commit/759b2dc64fbd69904b00be1b3e11c5897f2ad608
3. Facebook's xctool doesn't support XCUITests. No, the is no way to make it work. Do not try.
4. xcodebuild does have a -quiet flag, which stops it from writing out every file that it compiles. It doesn't, however, stop it from writing all compile warnings to stderr! https://github.com/dgcoffman/Stopwatch/commit/813df0d9f81ffeb2c3183a673dbed1705d1352a2
5. You do have to [set a "Development Team" in project settings](https://github.com/dgcoffman/Stopwatch/commit/5f3736882db766a2de9504acc7b9a1a331713a92#diff-e266983aaf3d6ff04f2126ca1ec13686R669), or xcodebuild will complain about it occasionally.
6. xcodebuild takes an argument like `-resultBundlePath TestResults` that causes it to write a bunch of test run metadata until the TestResults directory in your project. This is essential because you want to upload that to Circle as a test artifact, and use the TestSummaries.plist file in there as the source for your JUnit-formatted XML (the thing Circle uses to show you a test summary). This is important!
7. SwiftLint has an `autocorrect` command and SwiftFormat has a `lint` command, so these tools are basically inverse of each other. But you should use them both, since SwiftLint's format is not sufficiently opinionated.


See also my initial research and thoughts about the iOS|Swift ecosystem and tools: https://gist.github.com/dgcoffman/620cd50ce94bdd03b78f67179e92de1a
