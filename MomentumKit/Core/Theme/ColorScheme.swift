import SwiftUI

enum ColorScheme: String {
    case chill
    case gameboy

    var path: String { rawValue.capitalized }
}

enum ColorToken {
    case primary
    case secondary
    case accent

    var name: String {
        switch self {
        case .primary: return "primary"
        case .secondary: return "secondary"
        case .accent: return "accent"
        }
    }
}
