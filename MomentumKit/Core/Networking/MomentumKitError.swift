import Foundation

enum MomentumKitError: Error {
  case badRequest
  case decodeError
  case load(Error)
}
