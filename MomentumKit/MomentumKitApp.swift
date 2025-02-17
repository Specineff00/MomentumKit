//
//  MomentumKitApp.swift
//  MomentumKit
//
//  Created by Yogesh N Ramsorrun on 03/02/2025.
//

import ComposableArchitecture
import SwiftData
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
    .modelContainer(for: Note.self)
  }
}
