//
//  LapTableViewController.swift
//  Stopwatch
//
//  Created by Dan Coffman on 4/9/19.
//  Copyright © 2019 Dan Coffman. All rights reserved.
//

import Foundation
import SnapKit
import UIKit

class LapTableViewController: UITableViewController {
    struct Lap {
        let lapNumber: Int
        let time: TimeInterval

        init(lapNumber: Int, time: TimeInterval) {
            self.lapNumber = lapNumber
            self.time = time
        }
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
            rowContainer.distribution = .fillProportionally
            rowContainer.alignment = .bottom

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

    private var lapNumber = 1
    private var laps: [Lap] = Array()

    private func reRender() {
        let indexPath = IndexPath(row: 0, section: 0) // Always insert the row at the top of the table
        tableView.beginUpdates()
        tableView.insertRows(at: [indexPath], with: .automatic)
        tableView.endUpdates()
    }

    func record(elapsed: TimeInterval) {
        laps.append(Lap(lapNumber: lapNumber, time: elapsed)) // Do I need lapNumber in here?
        lapNumber += 1
        reRender()
    }

    func clear() {
        lapNumber = 1;
        laps = Array()
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(Row.self, forCellReuseIdentifier: "Row")
    }

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return lapNumber - 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // A hell of off-by-one errors
        let lapNumber = laps.count - indexPath.row
        let time: TimeInterval = laps[lapNumber - 1].time
        let displayTime = ElapsedTimeDisplay.getElapsedString(elapsed: time)
        let cell: Row = tableView.dequeueReusableCell(withIdentifier: "Row", for: indexPath as IndexPath) as! Row
        cell.leftContent.text = "Lap \(lapNumber)"
        cell.rightContent.text = displayTime
        return cell
    }
}
