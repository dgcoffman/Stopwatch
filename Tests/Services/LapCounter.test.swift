import Nimble
import Quick

@testable import Stopwatch

class LapCounterSpec: QuickSpec {
    override func spec() {
        describe("LapCounter") {
            var lapCounter: LapCounter!

            beforeEach {
                lapCounter = LapCounter()
            }

            describe("insert") {
                it("increases count") {
                    expect(lapCounter.count).to(equal(0))
                    lapCounter.insert(value: 1)
                    expect(lapCounter.count).to(equal(1))
                }
            }
        }
    }
}
