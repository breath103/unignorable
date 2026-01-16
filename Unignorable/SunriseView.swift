import SwiftUI
import AppKit
import QuartzCore

struct SunriseView: View {
    let onComplete: () -> Void

    var body: some View {
        SunriseEmitterView(onComplete: onComplete)
            .ignoresSafeArea()
    }
}

class SunriseNSView: NSView {
    private var gradientLayer: CAGradientLayer?
    private var hasStarted = false
    private var timer: Timer?
    private var startTime: CFTimeInterval = 0
    private let duration: Double = 4.0
    private let fadeOutDuration: Double = 0.5
    var onComplete: (() -> Void)?

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        wantsLayer = true
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        wantsLayer = true
    }

    override func layout() {
        super.layout()
        guard bounds.width > 0, bounds.height > 0 else { return }

        if !hasStarted {
            hasStarted = true
            setupLayers()
            startAnimation()
        }
    }

    private func setupLayers() {
        let gradient = CAGradientLayer()
        gradient.type = .radial
        gradient.colors = [
            NSColor.yellow.cgColor,
            NSColor.orange.withAlphaComponent(0.6).cgColor,
            NSColor.orange.withAlphaComponent(0.2).cgColor,
            NSColor.clear.cgColor
        ]
        gradient.locations = [0, 0.1, 0.4, 1.0]
        gradient.startPoint = CGPoint(x: 0.5, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.opacity = 0
        layer?.addSublayer(gradient)
        self.gradientLayer = gradient
    }

    private func startAnimation() {
        startTime = CACurrentMediaTime()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0/60.0, repeats: true) { [weak self] _ in
            self?.updateFrame()
        }
    }

    private func updateFrame() {
        let elapsed = CACurrentMediaTime() - startTime
        var progress = min(elapsed / duration, 1.0)

        // Ease out
        progress = 1 - pow(1 - progress, 3)

        // Fade out near end
        var opacity = 1.0
        if elapsed > duration - fadeOutDuration {
            opacity = max(0, (duration - elapsed) / fadeOutDuration)
        }

        updateAnimation(progress: progress, opacity: opacity)

        if elapsed >= duration {
            timer?.invalidate()
            timer = nil
            onComplete?()
        }
    }

    private func updateAnimation(progress: Double, opacity: Double) {
        guard let gradient = gradientLayer else { return }

        let size = max(bounds.width, bounds.height) * 2.5

        // Sun position: starts below screen, rises to lower third
        let startY = -size / 2
        let endY = bounds.height * 0.4
        let sunY = startY + (endY - startY) * CGFloat(progress)
        let sunX = bounds.midX

        CATransaction.begin()
        CATransaction.setDisableActions(true)

        gradient.frame = CGRect(
            x: sunX - size / 2,
            y: sunY - size / 2,
            width: size,
            height: size
        )
        gradient.opacity = Float(opacity * progress)

        CATransaction.commit()
    }

    deinit {
        timer?.invalidate()
    }
}

struct SunriseEmitterView: NSViewRepresentable {
    let onComplete: () -> Void

    func makeNSView(context: Context) -> SunriseNSView {
        let view = SunriseNSView()
        view.onComplete = onComplete
        return view
    }

    func updateNSView(_ nsView: SunriseNSView, context: Context) {}
}

#Preview {
    SunriseView {
        print("Sunrise completed")
    }
}
