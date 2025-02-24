import SwiftUI

struct MomentumPrimaryStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .appFont(.button)
            .padding()
            .background(Color.primaryInteractive)
            .foregroundColor(.text)
            .clipShape(Capsule())
    }
}

struct MomentumSecondaryStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .appFont(.button)
            .padding()
            .foregroundColor(.background)
            .capsuleBorder(.primaryInteractive, width: 1)
    }
}

struct MomentumButton2: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .appFont(.button)
            .padding()
            .background(Color.primaryInteractive)
            .foregroundColor(.inverseText)
            .clipShape(Capsule())
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    VStack {
        Button("Click me") {}
            .buttonStyle(MomentumPrimaryStyle())
        Button("Click me") {}
            .buttonStyle(MomentumSecondaryStyle())
        Button("Click me") {}
            .buttonStyle(MomentumButton2())
    }
    .padding(
    )
}

extension View {
    func capsuleBorder(_ color: Color, width: CGFloat) -> some View {
        overlay(Capsule().stroke(color, lineWidth: width))
    }
}
