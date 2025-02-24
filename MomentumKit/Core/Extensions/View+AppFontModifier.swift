import SwiftUI

extension View {
    func appFont(_ textStyle: FontManager.TextStyle) -> some View {
        modifier(AppFontModifier(textStyle: textStyle))
    }
}
