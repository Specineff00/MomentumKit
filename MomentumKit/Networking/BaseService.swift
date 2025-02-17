import Foundation

protocol BaseServiceProtocol {
  var baseURL: String { get }
  func dispatch<R: Request>(_ request: R) async throws -> R.ReturnType
}

actor LiveBaseService: BaseServiceProtocol {
  let baseURL: String

  init(baseURL: String = "https://api.disneyapi.dev") {
    self.baseURL = baseURL
  }

  func dispatch<R>(_ request: R) async throws -> R.ReturnType where R: Request {
    guard let urlRequest = request.asURLRequest(baseURL: baseURL) else {
      throw DisneeError.badRequest
    }

    return try await withCheckedThrowingContinuation { continuation in
      AF.request(urlRequest).responseDecodable(of: R.ReturnType.self) { response in
        switch response.result {
        case .success(let success):
          continuation.resume(returning: success)
        case .failure(let error):
          continuation.resume(throwing: error)
        }
      }
    }
  }
}

struct MockBaseService: BaseServiceProtocol {
  var baseURL: String = "baseurl.com"
  var dispatchHandler: (Any) throws -> Any

  init(dispatchHandler: @escaping (Any) throws -> Any) {
    self.dispatchHandler = dispatchHandler
  }

  func dispatch<R>(_ request: R) async throws -> R.ReturnType where R: Request {
    let result = try dispatchHandler(request)
    guard let returnValue = result as? R.ReturnType else {
        throw NSError(domain: "MockAPIService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Type mismatch"])
    }
    return returnValue
  }
}
