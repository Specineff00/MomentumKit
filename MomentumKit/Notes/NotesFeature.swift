import ComposableArchitecture

@Reducer
struct NotesFeature {
    @ObservableState
    struct State: Equatable {
        var pendingText = ""
        var notes: [Note] = []
    }

    enum Action {
        case onAppear
        case saveNote(Note)
        case onLoadingResponse(Result<[Note], MomentumKitError>)
        case onSavingResponse(Result<Void, MomentumKitError>)
    }

    @Dependency(\.momentumAPI) var momentumAPI

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return whenLoading()

            case let .saveNote(note):
                return whenSaving(note)

            case let .onLoadingResponse(result):
                switch result {
                case let .success(notes):
                    print(notes)
                    state.notes = notes
                case let .failure(error):
                    print(error)
                }
                return .none

            case let .onSavingResponse(result):
                switch result {
                case .success:
                    print("saved!")
                case let .failure(error):
                    print(error)
                }
                return .none
            }
        }
    }

    private func whenLoading() -> EffectOf<Self> {
        .run { send in
            do {
                let notes = try await momentumAPI.fetchAllNotes()
                await send(.onLoadingResponse(.success(notes)))
            } catch {
                await send(.onLoadingResponse(.failure(error as! MomentumKitError)))
            }
        }
    }

    private func whenSaving(_ note: Note) -> EffectOf<Self> {
        .run { send in
            do {
                try await momentumAPI.saveNote(note)
                await send(.onSavingResponse(.success(())))
            } catch {
                await send(.onSavingResponse(.failure(error as! MomentumKitError)))
            }
        }
    }
}

@Reducer
struct CreateNoteFeature {
    @ObservableState
    struct State: Equatable {
        var isLoading = false
        var pendingText = ""
        var category = ""
        var priotity: Int = 0
    }

    enum Action {
        case saveNote
        case savingResponse(Result<Void, MomentumKitError>)
    }

    @Dependency(\.momentumAPI) var momentumAPI
    @Dependency(\.dismiss) var dismiss

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .saveNote:
                state.isLoading = true
//                let note: Note = .init(
//                    text: state.pendingText,
//                    category: state.category,
//                    priority: state.priotity
//                )
                let note = Note.generateRandomNote()

                return whenSaving(note)

            case let .savingResponse(result):
                state.isLoading = false
                switch result {
                case .success:
                    print("save da note!")
                    return .run { _ in await dismiss() }
                case .failure:
                    print("Error saving note!")
                }
                return .none
            }
        }
    }

    private func whenSaving(_ note: Note) -> EffectOf<Self> {
        .run { send in
            do {
                try await momentumAPI.saveNote(note)
                await send(.savingResponse(.success(())))
            } catch {
                await send(.savingResponse(.failure(error as! MomentumKitError)))
            }
        }
    }
}
