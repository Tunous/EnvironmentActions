import Foundation

/// Action that can be stored in SwiftUI environment without causing unnecessary redraws of views which will access it.
@available(iOS 17.0.0, *)
public struct EnvironmentAction2<each Param>: Identifiable, Equatable {
    public let id: UUID
    private let action: ((repeat each Param)) -> Void

    public init(id: UUID, action: @escaping (repeat each Param) -> Void) {
        self.id = id
        self.action = { (args: (repeat each Param)) in
            action(repeat each args)
        }
    }

    public func callAsFunction(_ parameters: repeat each Param) {
        action((repeat each parameters))
    }

    public static func ==(lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}
