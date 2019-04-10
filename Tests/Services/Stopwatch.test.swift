import Nimble
import Quick

@testable import Stopwatch

class StopWatchSpec: QuickSpec {
    override func spec() {
        describe("Stopwatch") {
            var stopWatch: Stopwatch!

            beforeEach {
                stopWatch = Stopwatch(interval: 0.001)
            }

            describe("starting") {
                it("calls onStart") {
                    var hasBeenCalled = false
                    stopWatch.onStart = {
                        hasBeenCalled = true
                    }

                    stopWatch.start()
                    expect(hasBeenCalled).to(equal(true))
                }
            }
        }
    }
}
