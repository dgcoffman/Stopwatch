import SnapKit
import UIKit

let defaultTimeInterval = 0.001

class StopwatchView: UIViewController {
    private let stopwatch: Stopwatch
    private let laps: LapTable

    private let elapsedLabel = ElapsedTimeDisplay()

    private let startStopButton: Button = {
        let button = Button(text: "Start")
        button.addTarget(self, action: #selector(startStopwatch), for: .touchUpInside)
        button.accessibilityIdentifier = "startStopButton" // put this in the constructor
        return button
    }()

    private let resetButton: Button = {
        let button = Button(text: "Reset")
        button.addTarget(self, action: #selector(reset), for: .touchUpInside)
        button.accessibilityIdentifier = "resetButton"
        return button
    }()

    private let lapButton: Button = {
        let button = Button(text: "Lap")
        button.addTarget(self, action: #selector(recordLapTime), for: .touchUpInside)
        button.accessibilityIdentifier = "lapButton"
        return button
    }()

    convenience init(interval: Double = defaultTimeInterval) {
        let stopwatch = Stopwatch(interval: interval)
        self.init(stopwatch: stopwatch)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(stopwatch: Stopwatch, laps: LapTable = LapTable()) {
        self.stopwatch = stopwatch
        self.laps = laps

        super.init(nibName: nil, bundle: nil)

        stopwatch.onStart = handleStart
        stopwatch.onStop = handleStop
        stopwatch.onTick = handleTick
    }

    private func replaceButtonTarget(withAction action: Selector) {
        startStopButton.removeTarget(nil, action: nil, for: .allEvents)
        startStopButton.addTarget(self, action: action, for: .touchUpInside)
    }

    private func handleStart() {
        replaceButtonTarget(withAction: #selector(stopStopwatch))
        startStopButton.setTitle("Stop", for: .normal)
    }

    private func handleStop() {
        replaceButtonTarget(withAction: #selector(startStopwatch))
        startStopButton.setTitle("Start", for: .normal)
    }

    private func handleTick(elapsed: TimeInterval) {
        elapsedLabel.elapsed = elapsed
    }

    @objc func startStopwatch() {
        stopwatch.start()
    }

    @objc func stopStopwatch() {
        stopwatch.stop()
    }

    @objc func reset() {
        stopwatch.reset()
        laps.clear()
    }

    @objc func recordLapTime() {
        laps.record(elapsed: stopwatch.elapsed)
    }

    private func initBackground() {
        let gradientStartColor = UIColor(
            red: CGFloat(10 / 255.0),
            green: CGFloat(80 / 255.0),
            blue: CGFloat(180 / 255.0),
            alpha: CGFloat(1.0)
        ).cgColor

        let gradientEndColor = gradientStartColor.copy(alpha: 0.6)

        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [gradientStartColor, gradientEndColor!]
        view.layer.insertSublayer(gradient, at: 0)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        initBackground()

        let buttonContainer = UIStackView(arrangedSubviews: [resetButton, lapButton, startStopButton])
        buttonContainer.axis = .horizontal
        buttonContainer.spacing = 24
        buttonContainer.distribution = .fillProportionally
        buttonContainer.alignment = .bottom

        let layout = UIStackView(arrangedSubviews: [elapsedLabel, laps.tableView, buttonContainer])
        layout.translatesAutoresizingMaskIntoConstraints = false
        layout.axis = .vertical
        layout.distribution = .fillEqually
        layout.alignment = .center

        view.addSubview(layout)

        layout.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(view.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.centerX.equalTo(view.snp.centerX)
        }

        laps.tableView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(elapsedLabel.snp.bottom)
            make.bottom.equalTo(buttonContainer.snp.top)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
        }

        buttonContainer.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(view.safeAreaLayoutGuide.snp.width).offset(-48)
        }

        startStopButton.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(100)
        }

        resetButton.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(100)
        }

        lapButton.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(100)
        }
    }
}
