import Foundation
import SwiftUI

extension View {
    /// Registers action in environment under the given `keyPath`.
    ///
    /// - Parameters:
    ///   - keyPath: Key path to environment action.
    ///   - action: Action to be performed when child views call the action under given `keyPath`.
    public func environmentThrowingAction<Params>(
        _ keyPath: WritableKeyPath<EnvironmentValues, EnvironmentThrowingAction<Params>>,
        perform action: @escaping (Params) throws -> Void
    ) -> some View {
        self.modifier(HandleEnvironmentThrowingActionModifier(keyPath: keyPath, action: action))
    }

    /// Registers action in environment under the given `keyPath`.
    ///
    /// - Parameters:
    ///   - keyPath: Key path to environment action.
    ///   - action: Action to be performed when child views call the action under given `keyPath`.
    public func environmentThrowingAction(
        _ keyPath: WritableKeyPath<EnvironmentValues, EnvironmentThrowingAction<Void>>,
        perform action: @escaping () throws -> Void
    ) -> some View {
        self.modifier(HandleEnvironmentThrowingActionModifier(keyPath: keyPath, action: action))
    }

    /// Registers action in environment under the given `keyPath`.
    ///
    /// - Parameters:
    ///   - keyPath: Key path to environment action.
    ///   - action: Action to be performed when child views call the action under given `keyPath`.
    public func environmentOptionalThrowingAction<Params>(
        _ keyPath: WritableKeyPath<EnvironmentValues, EnvironmentThrowingAction<Params>?>,
        perform action: @escaping (Params) throws -> Void
    ) -> some View {
        self.modifier(HandleOptionalEnvironmentThrowingActionModifier(keyPath: keyPath, action: action))
    }

    /// Registers action in environment under the given `keyPath`.
    ///
    /// - Parameters:
    ///   - keyPath: Key path to environment action.
    ///   - action: Action to be performed when child views call the action under given `keyPath`.
    public func environmentOptionalThrowingAction(
        _ keyPath: WritableKeyPath<EnvironmentValues, EnvironmentThrowingAction<Void>?>,
        perform action: @escaping () throws -> Void
    ) -> some View {
        self.modifier(HandleOptionalEnvironmentThrowingActionModifier(keyPath: keyPath, action: action))
    }
}

private struct HandleEnvironmentThrowingActionModifier<Params>: ViewModifier {
    let keyPath: WritableKeyPath<EnvironmentValues, EnvironmentThrowingAction<Params>>
    let action: (Params) throws -> Void

    @State private var actionId = UUID()

    func body(content: Content) -> some View {
        return content.environment(keyPath, EnvironmentThrowingAction(id: actionId, action: action))
    }
}

private struct HandleOptionalEnvironmentThrowingActionModifier<Params>: ViewModifier {
    let keyPath: WritableKeyPath<EnvironmentValues, EnvironmentThrowingAction<Params>?>
    let action: (Params) throws -> Void

    @State private var actionId = UUID()

    func body(content: Content) -> some View {
        return content.environment(keyPath, EnvironmentThrowingAction(id: actionId, action: action))
    }
}
