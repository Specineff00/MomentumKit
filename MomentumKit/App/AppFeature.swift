import ComposableArchitecture

@Reducer
struct AppFeature {
    @Reducer
    enum Destination {
        case createNote(CreateNoteFeature)
    }

    @ObservableState
    struct State: Equatable {
        @Presents var destination: Destination.State?
        var notes = NotesFeature.State()
        var quotes = QuotesFeature.State()
    }

    enum Action {
        case createNote
        case notes(NotesFeature.Action)
        case quotes(QuotesFeature.Action)
        case destination(PresentationAction<Destination.Action>)
    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .createNote:
                state.destination = .createNote(CreateNoteFeature.State())
                return .none
            default: return .none
            }
        }
        Scope(state: \.notes, action: \.notes) {
            NotesFeature()
        }
        Scope(state: \.quotes, action: \.quotes) {
            QuotesFeature()
        }
        .ifLet(\.$destination, action: \.destination)
    }
}

// Required always when adding modal destinations
extension AppFeature.Destination.State: Equatable {}
