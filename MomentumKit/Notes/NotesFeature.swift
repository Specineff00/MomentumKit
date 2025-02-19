import ComposableArchitecture

@Reducer
struct NotesFeature {

  @ObservableState
  struct State {
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

      case .saveNote(let note):
        return whenSaving(note)

      case .onLoadingResponse(let result):
        switch result {
        case .success(let notes):
          print(notes)
          state.notes = notes
        case .failure(let error):
          print(error)
        }
        return .none

      case .onSavingResponse(let result):
        switch result {
        case .success:
          print("saved!")
        case .failure(let error):
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
