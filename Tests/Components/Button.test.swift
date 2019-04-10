import Nimble
import Quick

@testable import Stopwatch

class ButtonSpec: QuickSpec {
    override func spec() {
        let text = "OK"

        describe("Button") {
            var button: Button!

            beforeEach {
                button = Button(text: text)
            }

            describe("title") {
                it("takes value from init") {
                    expect(button.currentTitle!).to(equal(text))
                }
            }
        }
    }
}
