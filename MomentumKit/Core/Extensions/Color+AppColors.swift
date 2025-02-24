import Dependencies
import SwiftUI

extension Color {
    @Dependency(\.appColorScheme) private static var scheme

    static func color(_ token: ColorToken) -> Color {
        Color("\(scheme.path)/\(token.name)", bundle: .main)
    }

    static let background = color(.primary) // Full background
    static let card = color(.secondary) // Cards, elevated content
    static let elevated = color(.primary) // Modals, sheets (often with shadow) // dont need??
    static let overlay = Color.black.opacity(0.4) // Overlay for modals

    static let onBackground = color(.secondary)
    static let onCard = color(.primary).opacity(0.7)

    static let primaryInteractive = color(.accent) // Main CTAs
    static let secondaryInteractive = color(.secondary) // Secondary actions
    static let pressed = color(.accent).opacity(0.5) // Darker
    static let disabled = Color.gray // Disabled state

    static let text = color(.primary)
    static let inverseText = color(.secondary)

    static let success = Color.green
    static let warning = Color.orange
    static let error = Color.red
    static let info = color(.accent)
}
