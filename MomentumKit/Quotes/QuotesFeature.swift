import ComposableArchitecture

@Reducer
struct QuotesFeature {

  @ObservableState
  struct State: Equatable {
    var quotes: [Quote] = []
  }

  enum Action {
    case loadQuotes
    case loadResponse(Result<[Quote], MomentumKitError>)
    case saveQuote(Quote)
  }

  @Dependency(\.momentumAPI) var momentumAPI

  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .loadQuotes:
        return whenLoading()

      case .loadResponse(let result):
        switch result {
        case .success(let quotes):
          state.quotes = quotes
        case .failure(let error):
          print(error)
        }
        return .none

      case .saveQuote(let quote):
        return .none
      }
    }
  }

  private func whenLoading() -> EffectOf<Self> {
    .run { send in
      do {
        let quotes = try await momentumAPI.fetchQuotes()
        await send(.loadResponse(.success(quotes)))
      } catch {
        await send(.loadResponse(.failure(error as! MomentumKitError)))
      }
    }
  }
}
