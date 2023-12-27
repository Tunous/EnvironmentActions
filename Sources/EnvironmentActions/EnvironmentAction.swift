import Foundation

/// Action that can be stored in SwiftUI environment without causing unnecessary redraws of views which will access it.
public struct EnvironmentAction<Params>: Equatable {
    private let id: UUID
    private let action: (Params) -> Void
    
    public init(id: UUID, action: @escaping (Params) -> Void) {
        self.id = id
        self.action = action
    }

    /// Executes the action.
    ///
    /// - Parameter parameters: Action parameters.
    public func callAsFunction(_ parameters: Params) {
        action(parameters)
    }

    public static func ==(lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }

    /// An action that does nothing.
    public static var doNothing: Self {
        Self(id: UUID(), action: { _ in })
    }
}

extension EnvironmentAction where Params == Void {
    /// Executes the action.
    public func callAsFunction() {
        action(())
    }
}
