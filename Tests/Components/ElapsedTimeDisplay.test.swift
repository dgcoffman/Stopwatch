import Nimble
import Quick

@testable import Stopwatch

class ElapsedTimeDisplaySpec: QuickSpec {
    override func spec() {
        describe("ElapsedTimeDisplay") {
            var timeDisplay: ElapsedTimeDisplay!

            beforeEach {
                timeDisplay = ElapsedTimeDisplay()
            }

            describe("elapsed") {
                it("starts at zero") {
                    expect(timeDisplay.elapsed).to(equal(0))
                }
            }

            describe("text") {
                it("is formatted") {
                    expect(timeDisplay.text).to(equal("00:00:00"))
                }
            }
        }
    }
}
