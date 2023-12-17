import XCTest
@testable import EnvironmentActions

@available(iOS 17.0.0, *)
final class EnvironmentAction2Tests: XCTestCase {
    func testActionWithSingleParameter() {
        let expectation = expectation(description: "Action")
        let action = EnvironmentAction2(id: UUID()) { (param: String) in
            XCTAssertEqual(param, "Text")
            expectation.fulfill()
        }
        action("Text")
        waitForExpectations(timeout: 1)
    }

    func testActionWithMultipleParameters() {
        let expectation = expectation(description: "Action")
        let action = EnvironmentAction2(id: UUID()) { (first: String, second: Int) in
            XCTAssertEqual(first, "Test")
            XCTAssertEqual(second, 5)
            expectation.fulfill()
        }
        action("Test", 5)
        waitForExpectations(timeout: 1)
    }

    func testActionWithNoParameters() {
        let expectation = expectation(description: "Action")
        let action = EnvironmentAction2(id: UUID()) {
            expectation.fulfill()
        }
        action()
        waitForExpectations(timeout: 1)
    }

    func testActionsWithSameIdAreEqual() {
        let id = UUID()
        let action1 = EnvironmentAction2(id: id) {}
        let action2 = EnvironmentAction2(id: id) {}
        XCTAssertEqual(action1, action2)
    }

    func testActionsWithDifferentIdAreNotEqual() {
        let id1 = UUID()
        let id2 = UUID()
        let action1 = EnvironmentAction2(id: id1) {}
        let action2 = EnvironmentAction2(id: id2) {}
        XCTAssertNotEqual(action1, action2)
    }
}
