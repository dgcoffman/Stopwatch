/*
 This is a generic table that can render data from any class implementing
 the TableDataSource protocol.

 */

import Foundation
import SnapKit
import UIKit

protocol TableRowData {
    func getLeftContent() -> String
    func getRightContent() -> String
    var isBest: Bool { get }
    var isWorst: Bool { get }
}

protocol TableDataSource {
    func clear()
    var count: Int { get }
    func at(index: Int) -> TableRowData?
}

class Table: UITableViewController {
    private let dataSource: TableDataSource

    init(dataSource: TableDataSource) {
        self.dataSource = dataSource
        super.init(style: .plain)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    internal func reRender() {
        let indexPath = IndexPath(row: 0, section: 0) // Always insert the row at the top of the table

        CATransaction.begin()
        CATransaction.setCompletionBlock {
            self.tableView.reloadData()
        }
        tableView.beginUpdates()
        tableView.insertRows(at: [indexPath], with: .automatic)
        tableView.endUpdates()
        CATransaction.commit()
    }

    func clear() {
        dataSource.clear()
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(Table.Row.self, forCellReuseIdentifier: "Row")
    }

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return dataSource.count
    }

    override func tableView(_: UITableView,
                            heightForRowAt _: IndexPath) -> CGFloat {
        return 60
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> Table.Row {
        let index = indexPath.row

        guard
            let dataPoint = dataSource.at(index: index),
            let cell = tableView.dequeueReusableCell(withIdentifier: "Row", for: indexPath as IndexPath) as? Table.Row
        else { fatalError() }

        cell.leftContent.text = dataPoint.getLeftContent()
        cell.rightContent.text = dataPoint.getRightContent()

        if dataSource.count > 1 {
            if dataPoint.isBest {
                cell.rightContent.textColor = UIColor.green
            } else if dataPoint.isWorst {
                cell.rightContent.textColor = UIColor.red
            } else {
                cell.rightContent.textColor = UIColor.black
            }
        }

        return cell
    }
}

extension Table {
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

            leftContent.font = UIFont(name: "AvenirNext-Medium", size: 16)!
            rightContent.font = UIFont(name: "AvenirNext-DemiBold", size: 20)!
            contentView.addSubview(rowContainer)

            rowContainer.snp.makeConstraints { (make) -> Void in
                make.top.equalTo(contentView.snp.top)
                make.bottom.equalTo(contentView.snp.bottom)
                make.left.equalTo(contentView.snp.left).offset(24)
                make.right.equalTo(contentView.snp.right).offset(-24)
            }
        }

        required init?(coder _: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}
