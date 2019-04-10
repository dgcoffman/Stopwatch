import Foundation
import UIKit

class LapTable: Table {
    let counter: LapCounter;

    init(dataSource: LapCounter = LapCounter()) {
        // Hold a more narrowly-typed reference to the dataSource here
        // So it can have a specifically typed insert func, not e.g. Any-typed
        // on the TableDataSource protocol.
        counter = dataSource;
        super.init(dataSource: dataSource)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func record(elapsed: TimeInterval) {
        counter.insert(value: elapsed)
        super.reRender()
    }
}
