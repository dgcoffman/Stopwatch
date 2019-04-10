import Nimble
import Quick

@testable import Stopwatch

class HomeViewSpec: QuickSpec {
    override func spec() {
        describe("HomeView") {
            var homeView: HomeView!

            beforeEach {
                homeView = HomeView()
            }

            describe("initial state") {
                it("exists") {
                    expect(homeView).toNot(beNil())
                }
            }
        }
    }
}
