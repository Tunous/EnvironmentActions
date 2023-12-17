import Foundation
import SwiftUI

extension View {
    /// Registers action in environment under the given `keyPath`.
    ///
    /// - Parameters:
    ///   - keyPath: Key path to environment action.
    ///   - action: Action to be performed when child views call the action under given `keyPath`.
    public func environmentAction<Params>(
        _ keyPath: WritableKeyPath<EnvironmentValues, EnvironmentAction<Params>>,
        perform action: @escaping (Params) -> Void
    ) -> some View {
        self.modifier(HandleEnvironmentActionModifier(keyPath: keyPath, action: action))
    }

    /// Registers action in environment under the given `keyPath`.
    ///
    /// - Parameters:
    ///   - keyPath: Key path to environment action.
    ///   - action: Action to be performed when child views call the action under given `keyPath`.
    public func environmentAction(
        _ keyPath: WritableKeyPath<EnvironmentValues, EnvironmentAction<Void>>,
        perform action: @escaping () -> Void
    ) -> some View {
        self.modifier(HandleEnvironmentActionModifier(keyPath: keyPath, action: action))
    }

    /// Registers action in environment under the given `keyPath`.
    ///
    /// - Parameters:
    ///   - keyPath: Key path to environment action.
    ///   - action: Action to be performed when child views call the action under given `keyPath`.
    public func environmentOptionalAction<Params>(
        _ keyPath: WritableKeyPath<EnvironmentValues, EnvironmentAction<Params>?>,
        perform action: @escaping (Params) -> Void
    ) -> some View {
        self.modifier(HandleOptionalEnvironmentActionModifier(keyPath: keyPath, action: action))
    }

    /// Registers action in environment under the given `keyPath`.
    ///
    /// - Parameters:
    ///   - keyPath: Key path to environment action.
    ///   - action: Action to be performed when child views call the action under given `keyPath`.
    public func environmentOptionalAction(
        _ keyPath: WritableKeyPath<EnvironmentValues, EnvironmentAction<Void>?>,
        perform action: @escaping () -> Void
    ) -> some View {
        self.modifier(HandleOptionalEnvironmentActionModifier(keyPath: keyPath, action: action))
    }
}

private struct HandleEnvironmentActionModifier<Params>: ViewModifier {
    let keyPath: WritableKeyPath<EnvironmentValues, EnvironmentAction<Params>>
    let action: (Params) -> Void

    @State private var actionId = UUID()

    func body(content: Content) -> some View {
        return content.environment(keyPath, EnvironmentAction(id: actionId, action: action))
    }
}

private struct HandleOptionalEnvironmentActionModifier<Params>: ViewModifier {
    let keyPath: WritableKeyPath<EnvironmentValues, EnvironmentAction<Params>?>
    let action: (Params) -> Void

    @State private var actionId = UUID()

    func body(content: Content) -> some View {
        return content.environment(keyPath, EnvironmentAction(id: actionId, action: action))
    }
}
