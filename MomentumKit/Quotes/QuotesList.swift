import ComposableArchitecture
import SwiftUI

struct QuotesList: View {
  let store: StoreOf<QuotesFeature>

  var body: some View {
    List(store.quotes) { note in
      Text(note.text)
    }
    .onAppear {
      store.send(.loadQuotes)
    }
  }
}
