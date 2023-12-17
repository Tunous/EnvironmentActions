import Foundation

/// Action that can be stored in SwiftUI environment without causing unnecessary redraws of views which will access it.
public struct EnvironmentThrowingAction<Params>: Identifiable, Equatable {
    public let id: UUID
    private let action: (Params) throws -> Void

    public init(id: UUID, action: @escaping (Params) throws -> Void) {
        self.id = id
        self.action = action
    }

    public func callAsFunction(_ parameters: Params) throws {
        try action(parameters)
    }

    public static func ==(lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }

    public static var doNothing: Self {
        Self(id: UUID(), action: { _ in })
    }
}

extension EnvironmentThrowingAction where Params == Void {
    public func callAsFunction() throws {
        try action(())
    }
}
