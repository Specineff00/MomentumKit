import ComposableArchitecture
import SwiftUI

@main
struct MomentumKitApp: App {
  @MainActor
  static let store = Store(initialState: AppFeature.State()) {
    AppFeature()
  }

  var body: some Scene {
    WindowGroup {
      HomeView(store: Self.store)
    }
  }
}
