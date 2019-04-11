import Nimble
import Quick

@testable import Stopwatch

class StopwatchViewSpec: QuickSpec {
    override func spec() {
        describe("StopwatchView") {
            var stopwatchView: StopwatchView!

            beforeEach {
                stopwatchView = StopwatchView()
            }

            describe("initial state") {
                it("exists") {
                    expect(stopwatchView).toNot(beNil())
                }
            }
        }
    }
}
