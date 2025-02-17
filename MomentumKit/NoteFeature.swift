import ComposableArchitecture
import SwiftData

@Reducer
struct NoteFeature {

  @ObservableState
  struct State {
    var pendingText = ""
  }

  enum Action {
    case saveText(String)
  }

  @Dependency(\.persistentStorage) var persistentStorage

  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .saveText(let text):
        persistentStorage.saveNote(.init(text: text))
        return .none
      }
    }
  }
}


@Model
class Note {
  var text: String

  init(text: String) {
    self.text = text
  }

}

extension Note {
  static let mock = Note(text: "Hello, World!")
}

extension [Note] {
  static let mock: [Note] = [.mock]
}
