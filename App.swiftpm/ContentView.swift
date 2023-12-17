import SwiftUI
import EnvironmentActions

struct ContentView: View {
    @State private var text = ""
    @State private var bool = false

    var body: some View {
        Self._printChanges()
        return VStack {
            Text(text)
            Toggle("Bool", isOn: $bool)
            ChildView()
        }
        .environmentAction(\.exampleAction) { param in
            text = param
            print(bool)
        }
    }
}

struct ChildView: View {
    @Environment(\.exampleAction) private var exampleAction

    @State private var text = ""

    var body: some View {
        Self._printChanges()
        return Button("Example") {
            text += "a"
            exampleAction(text)
        }
    }
}

private struct ExampleActionKey: EnvironmentKey {
    static let defaultValue: EnvironmentAction<String> = .doNothing
}

extension EnvironmentValues {
    var exampleAction: EnvironmentAction<String> {
        get { self[ExampleActionKey.self] }
        set { self[ExampleActionKey.self] = newValue }
    }
}
