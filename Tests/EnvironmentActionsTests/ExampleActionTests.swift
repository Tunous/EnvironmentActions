//
//  ExampleActionTests.swift
//
//
//  Created by Łukasz Rutkowski on 21/12/2023.
//

import XCTest
import SwiftUI
import EnvironmentActions

final class ExampleActionTests: XCTestCase {
    func testAccessEnvironmentAction() async throws {
    }

    struct ChildView: View {
        @Environment(\.exampleAction) private var exampleAction

        var body: some View {
            Button("Perform") {
                exampleAction("param")
            }
        }
    }

    struct ParentView: View {
        var body: some View {
            ChildView().environmentAction(\.exampleAction) { param in
                print("param")
            }
        }
    }
}


private struct ExampleActionKey: EnvironmentKey {
    static var defaultValue: EnvironmentAction<String> = .doNothing
}

private extension EnvironmentValues {
    var exampleAction: EnvironmentAction<String> {
        get { self[ExampleActionKey.self] }
        set { self[ExampleActionKey.self] = newValue }
    }
}
