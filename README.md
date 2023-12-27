# EnvironmentActions

Set of structs and extensions that can be used to store actions inside of SwiftUI environment without causing unnecessary redraws of depending views.

## Usage

1. Add `EnvironmentKey` and extension on `EnvironmentValues` with custom action. 

```swift
import SwiftUI
import EnvironmentActions

extension EnvironmentValues {
    var exampleAction: EnvironmentAction<String> {
        get { self[ExampleActionKey.self] }
        set { self[ExampleActionKey.self] = newValue }
    }
}

private struct ExampleActionKey: EnvironmentKey {
    static var defaultValue: EnvironmentAction<String> = .doNothing
}
```

2. Define in parent view what will happen when the action executes.

```swift
struct ContentView: View {
    var body: some View {
        ChildView().environmentAction(\.exampleAction) { param in
            print("Executed with parameter \(param)")
        }
    }
}
```

3. Access the action in child views.

```swift
struct ChildView: View {
    @Environment(\.exampleAction) private var exampleAction
    
    var body: some View {
        Button("Perform") {
            exampleAction("param")
        }
    }
}
```
