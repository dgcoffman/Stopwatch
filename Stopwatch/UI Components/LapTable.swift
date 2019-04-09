import Foundation
import SnapKit
import UIKit

// TODO: De-couple from LapCounter -- make generic LeftRightTable

class LapTable: UITableViewController {
    let lapCounter: LapCounter

    init(lapCounter: LapCounter = LapCounter()) {
        self.lapCounter = lapCounter
        super.init(style: .plain)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func reRender() {
        let indexPath = IndexPath(row: 0, section: 0) // Always insert the row at the top of the table
        tableView.beginUpdates()
        tableView.insertRows(at: [indexPath], with: .automatic)
        tableView.endUpdates()
    }

    func record(elapsed: TimeInterval) {
        lapCounter.record(elapsed: elapsed)
        reRender()
    }

    func clear() {
        lapCounter.clear()
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(Row.self, forCellReuseIdentifier: "Row")
    }

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return lapCounter.lapCount
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let lap = lapCounter.lastLap,
            let cell = tableView.dequeueReusableCell(withIdentifier: "Row", for: indexPath as IndexPath) as? Row
        else { fatalError() }

        cell.leftContent.text = "Lap \(lap.lapNumber)"
        cell.rightContent.text = ElapsedTimeDisplay.getElapsedString(elapsed: lap.duration)

        return cell
    }

    class Row: UITableViewCell {
        let leftContent = UILabel()
        let rightContent = UILabel()

        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)

            leftContent.translatesAutoresizingMaskIntoConstraints = false
            rightContent.translatesAutoresizingMaskIntoConstraints = false

            let rowContainer = UIStackView(arrangedSubviews: [leftContent, rightContent])
            rowContainer.axis = .horizontal
            rowContainer.distribution = .equalSpacing

            contentView.addSubview(rowContainer)

            rowContainer.snp.makeConstraints { (make) -> Void in
                make.top.equalTo(contentView.snp.top)
                make.bottom.equalTo(contentView.snp.bottom)
                make.left.equalTo(contentView.snp.left)
                make.right.equalTo(contentView.snp.right)
            }
        }

        required init?(coder _: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}
