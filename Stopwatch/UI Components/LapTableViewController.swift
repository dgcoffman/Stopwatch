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
        let duration: TimeInterval
        let endTime: TimeInterval

        init(lapNumber: Int, duration: TimeInterval, endTime: TimeInterval) {
            self.lapNumber = lapNumber
            self.duration = duration
            self.endTime = endTime
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

    private var lapNumber = 1
    private var laps: [Lap] = Array()

    private func reRender() {
        let indexPath = IndexPath(row: 0, section: 0) // Always insert the row at the top of the table
        tableView.beginUpdates()
        tableView.insertRows(at: [indexPath], with: .automatic)
        tableView.endUpdates()
    }

    func record(elapsed: TimeInterval) {
        let lastLapEndTime = laps.last?.endTime ?? 0
        let lapDuration = elapsed - lastLapEndTime

        laps.append(Lap(lapNumber: lapNumber, duration: lapDuration, endTime: elapsed))
        lapNumber += 1
        reRender()
    }

    func clear() {
        lapNumber = 1
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
        guard
            let lap = laps.last,
            let cell = tableView.dequeueReusableCell(withIdentifier: "Row", for: indexPath as IndexPath) as? Row
        else { fatalError() }

        cell.leftContent.text = "Lap \(lap.lapNumber)"
        cell.rightContent.text = ElapsedTimeDisplay.getElapsedString(elapsed: lap.duration)

        return cell
    }
}
