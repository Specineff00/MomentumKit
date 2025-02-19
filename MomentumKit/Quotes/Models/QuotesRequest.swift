import Foundation

struct QuotesRequest: Request {
  typealias ReturnType = [Quote]
  var path: String { "/quotes" }
}
