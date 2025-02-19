import ComposableArchitecture
import SwiftUI

struct NotesList: View {
  let store: StoreOf<NotesFeature>

  var body: some View {
    List(store.notes) { note in
      Text(note.text)
    }
    .onAppear {
      store.send(.onAppear)
    }
  }
}
