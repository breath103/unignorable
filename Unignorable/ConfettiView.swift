//
//  ConfettiView.swift
//  Unignorable
//
//  Created by Kurt Lee on 2025-10-16.
//

import SwiftUI
import AppKit

struct ConfettiView: View {
    let onComplete: () -> Void

    @State private var confettiPieces: [ConfettiPiece] = []
    @State private var backdropOpacity: Double = 0.0
    private let confettiCount = 150
    private let duration: Double = 3.0
    private let fadeInDuration: Double = 0.3
    private let fadeOutDuration: Double = 0.3

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Semi-transparent background with fade animation
                Color.black.opacity(backdropOpacity * 0.3)
                    .ignoresSafeArea()

                // Confetti pieces
                ForEach(confettiPieces) { piece in
                    ConfettiShape(piece: piece)
                        .frame(width: piece.size, height: piece.size)
                        .foregroundColor(piece.color)
                        .position(piece.position)
                        .rotationEffect(.degrees(piece.rotation))
                }
            }
            .onAppear {
                generateConfetti(in: geometry.size)
                animateConfetti()
                playSound()

                // Fade in backdrop
                withAnimation(.easeIn(duration: fadeInDuration)) {
                    backdropOpacity = 1.0
                }

                // Auto-dismiss after duration with fade out
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
    }

    private func generateConfetti(in size: CGSize) {
        let colors: [Color] = [.red, .blue, .green, .yellow, .orange, .pink, .purple]

        confettiPieces = (0..<confettiCount).map { _ in
            ConfettiPiece(
                id: UUID(),
                position: CGPoint(x: CGFloat.random(in: 0...size.width), y: -50),
                targetY: size.height + 100,
                size: CGFloat.random(in: 8...16),
                color: colors.randomElement() ?? .red,
                rotation: 0,
                targetRotation: Double.random(in: -720...720)
            )
        }
    }

    private func animateConfetti() {
        for i in 0..<confettiPieces.count {
            let delay = Double.random(in: 0...0.5)
            let duration = Double.random(in: 2.0...3.5)

            withAnimation(
                .easeIn(duration: duration)
                .delay(delay)
            ) {
                confettiPieces[i].position.y = confettiPieces[i].targetY
            }

            withAnimation(
                .linear(duration: duration)
                .repeatForever(autoreverses: false)
                .delay(delay)
            ) {
                confettiPieces[i].rotation = confettiPieces[i].targetRotation
            }
        }
    }

    private func playSound() {
        // Play a celebratory system sound
        if let sound = NSSound(named: "Funk") {
            sound.play()
        }
    }
}

struct ConfettiPiece: Identifiable {
    let id: UUID
    var position: CGPoint
    let targetY: CGFloat
    let size: CGFloat
    let color: Color
    var rotation: Double
    let targetRotation: Double
}

struct ConfettiShape: View {
    let piece: ConfettiPiece

    var body: some View {
        RoundedRectangle(cornerRadius: 2)
    }
}

#Preview {
    ConfettiView {
        print("Confetti completed")
    }
}
