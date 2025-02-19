import ComposableArchitecture

@Reducer
struct AppFeature {
  @ObservableState
  struct State {
    var notes = NotesFeature.State()
    var quotes = QuotesFeature.State()
  }

  enum Action {
    case notes(NotesFeature.Action)
    case quotes(QuotesFeature.Action)
  }

  var body: some ReducerOf<Self> {
    Scope(state: \.notes, action: \.notes) {
      NotesFeature()
    }
    Scope(state: \.quotes, action: \.quotes) {
      QuotesFeature()
    }
  }
}

