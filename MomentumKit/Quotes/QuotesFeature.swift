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

            case let .loadResponse(result):
                switch result {
                case let .success(quotes):
                    state.quotes = quotes
                case let .failure(error):
                    print(error)
                }
                return .none

            case let .saveQuote(quote):
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
