import Nimble
import Quick

@testable import Stopwatch

class LapTableSpec: QuickSpec {
    override func spec() {
        describe("LapTable") {
            var table: LapTable!

            beforeEach {
                table = LapTable()
            }

            describe("record") {
                it("creates a row") {
                    table.record(elapsed: 1)

                    let index = IndexPath(row: 0, section: 0)

                    let cell = table.tableView(table.tableView, cellForRowAt: index)

                    expect(cell.leftContent.text).to(equal("Lap 1"))
                    expect(cell.rightContent.text).to(equal("00:01:00"))
                }
            }
        }
    }
}
