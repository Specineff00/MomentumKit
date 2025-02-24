import Dependencies

private struct ColorSchemeKey: DependencyKey {
    static let liveValue: ColorScheme = .chill
}

extension DependencyValues {
    var appColorScheme: ColorScheme {
        get { self[ColorSchemeKey.self] }
        set { self[ColorSchemeKey.self] = newValue }
    }
}
