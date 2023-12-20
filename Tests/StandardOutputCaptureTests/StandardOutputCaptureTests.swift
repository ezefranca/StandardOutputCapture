import XCTest
@testable import StandardOutputCapture

final class StandardOutputCaptureTests: XCTestCase {
    var outputCapture: StandardOutputCapture!

    override func setUp() {
        super.setUp()
        outputCapture = StandardOutputCapture()
    }

    override func tearDown() {
        outputCapture = nil
        super.tearDown()
    }
}
