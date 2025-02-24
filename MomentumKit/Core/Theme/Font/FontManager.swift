import SwiftUI

enum FontManager {
    enum TextStyle: String, CaseIterable {
        case headline
        case title
        case body
        case button
        case caption

        var font: Font {
            switch self {
            case .headline: return AppFonts.bold(size: 24)
            case .title: return AppFonts.medium(size: 20)
            case .body: return AppFonts.regular(size: 16)
            case .button: return AppFonts.bold(size: 16)
            case .caption: return AppFonts.regular(size: 12)
            }
        }
    }

    enum Weight {
        case regular
        case medium
        case bold
    }

    static func custom(_ weight: Weight, size: CGFloat) -> Font {
        switch weight {
        case .regular:
            AppFonts.regular(size: size)
        case .medium:
            AppFonts.medium(size: size)
        case .bold:
            AppFonts.bold(size: size)
        }
    }
}

extension FontManager.TextStyle: Identifiable {
    public var id: String { rawValue }
}

#Preview {
    VStack(alignment: .leading) {
        ForEach(FontManager.TextStyle.allCases) { style in
            Text(style.rawValue.capitalized)
                .appFont(.title)
                .underline(true)
            Text("The quick brown fox jumped ")
                .appFont(style)
                .padding(.bottom)
        }
    }
}
