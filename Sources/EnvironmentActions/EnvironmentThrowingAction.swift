import Foundation

/// Throwing action that can be stored in SwiftUI environment without causing unnecessary redraws of views which will access it.
public struct EnvironmentThrowingAction<Params>: Equatable {
    private let id: UUID
    private let action: (Params) throws -> Void

    internal init(id: UUID, action: @escaping (Params) throws -> Void) {
        self.id = id
        self.action = action
    }
    
    /// Executes the action.
    ///
    /// - Parameter parameters: Action parameters.
    public func callAsFunction(_ parameters: Params) throws {
        try action(parameters)
    }

    public static func ==(lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
    
    /// An action that does nothing.
    public static var doNothing: Self {
        Self(id: UUID(), action: { _ in })
    }
}

extension EnvironmentThrowingAction where Params == Void {
    /// Executes the action.
    public func callAsFunction() throws {
        try action(())
    }
}
