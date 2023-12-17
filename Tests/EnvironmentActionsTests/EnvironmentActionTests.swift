import XCTest
@testable import EnvironmentActions

final class EnvironmentActionTests: XCTestCase {
    func testActionWithSingleParameter() {
        let expectation = expectation(description: "Action")
        let action = EnvironmentAction(id: UUID()) { (param: String) in
            XCTAssertEqual(param, "Text")
            expectation.fulfill()
        }
        action("Text")
        waitForExpectations(timeout: 1)
    }

    func testActionWithMultipleParameters() {
        let expectation = expectation(description: "Action")
        let action = EnvironmentAction(id: UUID()) { (param: (String, Int)) in
            XCTAssertEqual(param.0, "Test")
            XCTAssertEqual(param.1, 5)
            expectation.fulfill()
        }
        action(("Test", 5))
        waitForExpectations(timeout: 1)
    }

    func testActionWithNoParameters() {
        let expectation = expectation(description: "Action")
        let action = EnvironmentAction(id: UUID()) {
            expectation.fulfill()
        }
        action()
        waitForExpectations(timeout: 1)
    }

    func testActionsWithSameIdAreEqual() {
        let id = UUID()
        let action1 = EnvironmentAction(id: id) {}
        let action2 = EnvironmentAction(id: id) {}
        XCTAssertEqual(action1, action2)
    }

    func testActionsWithDifferentIdAreNotEqual() {
        let id1 = UUID()
        let id2 = UUID()
        let action1 = EnvironmentAction(id: id1) {}
        let action2 = EnvironmentAction(id: id2) {}
        XCTAssertNotEqual(action1, action2)
    }
}

