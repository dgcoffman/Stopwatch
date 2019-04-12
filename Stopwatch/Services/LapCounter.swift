import Foundation

class LapCounter: TableDataSource {
    private var lapNumber = 1
    private var laps: [Lap] = Array()

    var count: Int {
        return lapNumber - 1
    }

    func getBestLapNumber() -> Int {
        let bestLap = laps.reduce(laps[0]) { best, lap in
            lap.duration < best.duration ? lap : best
        }
        return bestLap.lapNumber
    }

    func getWorstLapNumber() -> Int {
        let worstLap = laps.reduce(laps[0]) { best, lap in
            lap.duration > best.duration ? lap : best
        }
        return worstLap.lapNumber
    }

    struct Lap: TableRowData {
        let lapNumber: Int
        let duration: TimeInterval
        let endTime: TimeInterval

        var getBestLapNumber: () -> Int
        var getWorstLapNumber: () -> Int

        var isBest: Bool {
            return lapNumber == getBestLapNumber()
        }

        var isWorst: Bool {
            return lapNumber == getWorstLapNumber()
        }

        init(lapNumber: Int,
             duration: TimeInterval,
             endTime: TimeInterval,
             getBestLapNumber: @escaping () -> Int,
             getWorstLapNumber: @escaping () -> Int) {
            self.lapNumber = lapNumber
            self.duration = duration
            self.endTime = endTime
            self.getBestLapNumber = getBestLapNumber
            self.getWorstLapNumber = getWorstLapNumber
        }

        func getLeftContent() -> String {
            return "Lap \(lapNumber)"
        }

        func getRightContent() -> String {
            return ElapsedTimeDisplay.getElapsedString(elapsed: duration)
        }
    }

    func insert(value: TimeInterval) {
        let lastLapEndTime = laps.first?.endTime ?? 0
        let lapDuration = value - lastLapEndTime

        laps.insert(
            Lap(
                lapNumber: lapNumber,
                duration: lapDuration,
                endTime: value,
                getBestLapNumber: getBestLapNumber,
                getWorstLapNumber: getWorstLapNumber
            ),
            at: 0
        )

        lapNumber += 1
    }

    func clear() {
        lapNumber = 1
        laps = Array()
    }

    func at(index: Int) -> TableRowData? {
        return laps[index]
    }
}
