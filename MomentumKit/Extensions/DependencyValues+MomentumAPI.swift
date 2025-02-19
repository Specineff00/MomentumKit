import Dependencies
import Foundation

extension DependencyValues {
  var momentumAPI: any MomentumAPI {
    get { self[MomentumAPIKey.self] }
    set { self[MomentumAPIKey.self] = newValue }
  }
}

private enum MomentumAPIKey: DependencyKey {
  static let liveValue: any MomentumAPI = LiveMomentumAPI()
  static let testValue: any MomentumAPI = MockMomentumAPI { [.mock] }
}

