import Nimble
import Quick

@testable import Stopwatch

class DataSourceMock: TableDataSource {
    func at(index _: Int) -> TableRowData? {
        return nil
    }

    private(set) var cleared = false

    func clear() {
        cleared = true
    }

    var count: Int = 0

    var lastItem: TableRowData?
}

class TableSpec: QuickSpec {
    override func spec() {
        describe("Table") {
            var table: Table!
            let dataSource = DataSourceMock()

            beforeEach {
                table = Table(dataSource: dataSource)
            }

            describe("clear") {
                it("calls the clear method on its data source") {
                    table.clear()
                    expect(dataSource.cleared).to(beTrue())
                }
            }
        }
    }
}
