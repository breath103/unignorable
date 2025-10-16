import SwiftUI

struct SunriseView: View {
    let onComplete: () -> Void

    @State private var sunPosition: CGFloat = 1.0
    @State private var opacity: Double = 0.0
    private let duration: Double = 3.0
    private let fadeInDuration: Double = 0.3
    private let fadeOutDuration: Double = 0.3

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Gradient background - dark to warm sunrise colors
                LinearGradient(
                    colors: [
                        Color(red: 0.1, green: 0.1, blue: 0.2),  // Dark blue-purple
                        Color(red: 1.0, green: 0.4, blue: 0.2),   // Warm orange
                        Color(red: 1.0, green: 0.8, blue: 0.3)    // Bright yellow
                    ],
                    startPoint: .bottom,
                    endPoint: .top
                )
                .opacity(opacity)
                .ignoresSafeArea()

                // Sun
                ZStack {
                    // Glow effect
                    Circle()
                        .fill(
                            RadialGradient(
                                colors: [
                                    Color.yellow.opacity(0.6),
                                    Color.orange.opacity(0.3),
                                    Color.clear
                                ],
                                center: .center,
                                startRadius: 50,
                                endRadius: 150
                            )
                        )
                        .frame(width: 300, height: 300)

                    // Sun core
                    Circle()
                        .fill(
                            RadialGradient(
                                colors: [
                                    Color.yellow,
                                    Color.orange
                                ],
                                center: .center,
                                startRadius: 0,
                                endRadius: 60
                            )
                        )
                        .frame(width: 120, height: 120)
                }
                .position(
                    x: geometry.size.width / 2,
                    y: geometry.size.height * sunPosition
                )
            }
            .onAppear {
                // Fade in
                withAnimation(.easeIn(duration: fadeInDuration)) {
                    opacity = 1.0
                }

                // Animate sun rising
                withAnimation(.easeOut(duration: duration)) {
                    sunPosition = 0.35
                }

                // Fade out before dismiss
                DispatchQueue.main.asyncAfter(deadline: .now() + duration - fadeOutDuration) {
                    withAnimation(.easeOut(duration: fadeOutDuration)) {
                        opacity = 0.0
                    }
                }

                // Complete
                DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                    onComplete()
                }
            }
            .focusable()
            .onKeyPress(.escape) {
                onComplete()
                return .handled
            }
        }
    }
}

#Preview {
    SunriseView {
        print("Sunrise completed")
    }
}
