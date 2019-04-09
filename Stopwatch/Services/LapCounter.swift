import Foundation

class LapCounter {
    private var lapNumber = 1
    private var laps: [Lap] = Array()

    var lapCount: Int {
        return lapNumber - 1
    }

    var lastLap: Lap? {
        return laps.last
    }

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

    func record(elapsed: TimeInterval) {
        let lastLapEndTime = laps.last?.endTime ?? 0
        let lapDuration = elapsed - lastLapEndTime

        laps.append(Lap(lapNumber: lapNumber, duration: lapDuration, endTime: elapsed))
        lapNumber += 1
    }

    func clear() {
        lapNumber = 1
        laps = Array()
    }
}
