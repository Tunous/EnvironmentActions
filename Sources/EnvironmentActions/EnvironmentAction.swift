import Foundation

//@available(iOS, deprecated: 17.0, message: "Use EnvironmentAction2 instead")
/// Action that can be stored in SwiftUI environment without causing unnecessary redraws of views which will access it.
public struct EnvironmentAction<Params>: Identifiable, Equatable {
    public let id: UUID
    private let action: (Params) -> Void

    public init(id: UUID, action: @escaping (Params) -> Void) {
        self.id = id
        self.action = action
    }

    public func callAsFunction(_ parameters: Params) {
        action(parameters)
    }

    public static func ==(lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }

    public static var doNothing: Self {
        Self(id: UUID(), action: { _ in })
    }
}

extension EnvironmentAction where Params == Void {
    public func callAsFunction() {
        action(())
    }
}
