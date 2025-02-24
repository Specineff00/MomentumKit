import SwiftUI

struct AppFontModifier: ViewModifier {
    let textStyle: FontManager.TextStyle

    func body(content: Content) -> some View {
        content.font(textStyle.font)
    }
}
