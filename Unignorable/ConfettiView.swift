import SwiftUI
import AppKit
import QuartzCore

struct ConfettiView: View {
    let onComplete: () -> Void

    @State private var backdropOpacity: Double = 0.0
    private let duration: Double = 3.0
    private let fadeInDuration: Double = 0.3
    private let fadeOutDuration: Double = 0.3

    var body: some View {
        ConfettiEmitterView(backdropOpacity: $backdropOpacity, onTap: onComplete)
            .ignoresSafeArea()
            .onAppear {
                playSound()

                withAnimation(.easeIn(duration: fadeInDuration)) {
                    backdropOpacity = 1.0
                }

                DispatchQueue.main.asyncAfter(deadline: .now() + duration - fadeOutDuration) {
                    withAnimation(.easeOut(duration: fadeOutDuration)) {
                        backdropOpacity = 0.0
                    }
                }

                DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                    onComplete()
                }
            }
    }

    private func playSound() {
        if let sound = NSSound(named: "Funk") {
            sound.play()
        }
    }
}

class ConfettiNSView: NSView {
    private var emitterLayer: CAEmitterLayer?
    private var backdropLayer: CALayer?
    private var hasStarted = false
    var onTap: (() -> Void)?
    var backdropOpacity: Double = 0 {
        didSet {
            backdropLayer?.opacity = Float(backdropOpacity * 0.3)
        }
    }

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

        backdropLayer?.frame = bounds

        if let emitter = emitterLayer {
            emitter.frame = bounds
            emitter.emitterPosition = CGPoint(x: bounds.midX, y: bounds.midY)
        }

        if !hasStarted {
            hasStarted = true
            setupBackdrop()
            // Wait for backdrop to fade in first
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.setupEmitter()
            }
        }
    }

    private func setupBackdrop() {
        let backdrop = CALayer()
        backdrop.frame = bounds
        backdrop.backgroundColor = NSColor.black.cgColor
        backdrop.opacity = 0
        layer?.addSublayer(backdrop)
        self.backdropLayer = backdrop
    }

    override func mouseDown(with event: NSEvent) {
        onTap?()
    }

    override func keyDown(with event: NSEvent) {
        if event.keyCode == 53 {
            onTap?()
        } else {
            super.keyDown(with: event)
        }
    }

    override var acceptsFirstResponder: Bool { true }

    private func setupEmitter() {
        let emitterLayer = CAEmitterLayer()
        emitterLayer.frame = bounds
        emitterLayer.emitterPosition = CGPoint(x: bounds.midX, y: bounds.midY)
        emitterLayer.emitterShape = .point
        emitterLayer.renderMode = .oldestFirst

        let colors: [NSColor] = [
            .systemRed, .systemBlue, .systemGreen, .systemYellow,
            .systemOrange, .systemPink, .systemPurple, .cyan
        ]

        var cells: [CAEmitterCell] = []
        for color in colors {
            cells.append(makeConfettiCell(color: color, isRect: true))
            cells.append(makeConfettiCell(color: color, isRect: false))
        }

        emitterLayer.emitterCells = cells
        layer?.addSublayer(emitterLayer)
        self.emitterLayer = emitterLayer

        // Instant burst
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.02) {
            emitterLayer.birthRate = 0
        }
    }

    private func makeConfettiCell(color: NSColor, isRect: Bool) -> CAEmitterCell {
        let cell = CAEmitterCell()

        let size: CGFloat = 12
        let image = NSImage(size: NSSize(width: size, height: size), flipped: false) { rect in
            color.setFill()
            if isRect {
                NSBezierPath(rect: CGRect(x: 2, y: 0, width: size - 4, height: size)).fill()
            } else {
                NSBezierPath(ovalIn: CGRect(x: 2, y: 2, width: size - 4, height: size - 4)).fill()
            }
            return true
        }

        var imageRect = CGRect(origin: .zero, size: image.size)
        if let cgImage = image.cgImage(forProposedRect: &imageRect, context: nil, hints: nil) {
            cell.contents = cgImage
        }

        cell.birthRate = 800
        cell.lifetime = 2.5
        cell.lifetimeRange = 0.5

        cell.velocity = 900
        cell.velocityRange = 300
        cell.emissionRange = .pi * 2

        // Negative = gravity pulls DOWN
        cell.yAcceleration = -600

        cell.scale = 1.0
        cell.scaleRange = 0.4

        cell.spin = 3
        cell.spinRange = 6

        cell.alphaSpeed = -0.3

        return cell
    }
}

struct ConfettiEmitterView: NSViewRepresentable {
    @Binding var backdropOpacity: Double
    let onTap: () -> Void

    func makeNSView(context: Context) -> ConfettiNSView {
        let view = ConfettiNSView()
        view.onTap = onTap
        return view
    }

    func updateNSView(_ nsView: ConfettiNSView, context: Context) {
        nsView.backdropOpacity = backdropOpacity
    }
}

#Preview {
    ConfettiView {
        print("Confetti completed")
    }
}
