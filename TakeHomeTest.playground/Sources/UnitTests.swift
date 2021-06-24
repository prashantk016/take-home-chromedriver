import XCTest

let driverUrl="http://localhost:9515/"

public func test_InvalidDriverUrl() {

    XCTAssertThrowsError(try BrowserDriver(driverURL:"localhost:1234"), "Invalid driver url test failed") { error -> Void in
        guard case BrowserDriverError.HttpRequestError = error else {
                              return XCTFail()
        }
    }
}

public func test_InvalidNagivationUrl() {
    let browserDriver=try? BrowserDriver(driverURL:driverUrl)

    XCTAssertThrowsError(try browserDriver!.navigateTo(url: "https://www.appleicloud.com/"), "Invalid navigation url test failed") { error in
        guard case BrowserDriverError.DriverRequestError = error else {
                       return XCTFail()
        }
    }
    try? browserDriver?.deleteSession()
}

public func test_ActionAfterSessionDeleted() {
    let browserDriver=try? BrowserDriver(driverURL:driverUrl)
    try? browserDriver?.deleteSession()
    XCTAssertThrowsError(try browserDriver!.navigateTo(url: "https://www.icloud.com/"), "Action after session deleted test failed") { error in
        guard case BrowserDriverError.DriverRequestError = error else {
                              return XCTFail()
        }
    }
}

public func test_ValidScenario() {
    let browserDriver=try? BrowserDriver(driverURL:driverUrl)

    XCTAssertNoThrow(try browserDriver?.maximizeWindow())
    XCTAssertNoThrow(try browserDriver?.navigateTo(url: "https://www.icloud.com/"))
    XCTAssertNoThrow(try browserDriver?.deleteSession())
}
