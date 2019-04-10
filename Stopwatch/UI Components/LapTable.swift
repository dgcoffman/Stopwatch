import Foundation
import UIKit

class LapTable: Table {
    init(dataSource: LapCounter = LapCounter()) {
        super.init(dataSource: dataSource)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func record(elapsed: TimeInterval) {
        dataSource.insert(value: elapsed)
        super.reRender()
    }
}
