import Foundation

class LapCounter: TableDataSource {
    private var lapNumber = 1
    private var laps: [Lap] = Array()

    var count: Int {
        return lapNumber - 1
    }

    var lastItem: TableRowData? {
        return laps.last
    }

    struct Lap: TableRowData {
        let lapNumber: Int
        let duration: TimeInterval
        let endTime: TimeInterval

        init(lapNumber: Int, duration: TimeInterval, endTime: TimeInterval) {
            self.lapNumber = lapNumber
            self.duration = duration
            self.endTime = endTime
        }

        func getLeftContent() -> String {
            return "Lap \(lapNumber)"
        }

        func getRightContent() -> String {
            return ElapsedTimeDisplay.getElapsedString(elapsed: duration)
        }
    }

    func insert(value: Any) {
        guard let value = value as? TimeInterval else { fatalError("LapCounter.insert only accepts values of type TimeInterval") }
        let lastLapEndTime = laps.last?.endTime ?? 0
        let lapDuration = value - lastLapEndTime

        laps.append(Lap(lapNumber: lapNumber, duration: lapDuration, endTime: value))
        lapNumber += 1
    }

    func clear() {
        lapNumber = 1
        laps = Array()
    }
}
