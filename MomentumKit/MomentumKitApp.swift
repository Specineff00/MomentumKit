import ComposableArchitecture
import SwiftUI

@main
struct MomentumKitApp: App {
  @MainActor
  static let store = Store(initialState: NoteFeature.State()) {
    NoteFeature()
  }

  var body: some Scene {
    WindowGroup {
      NotesView(store: Self.store)
    }
  }
}
