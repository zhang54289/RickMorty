//
//  RickMortyUITests.swift
//  RickMortyUITests
//
//  Created by Huan Zhang on 4/9/25.
//

import XCTest

final class RickMortyUITests: XCTestCase {
    func testLaunchAndSearch() throws {
        let app = XCUIApplication()
        app.launch()

        let searchField = app.textFields["Search name"]
        XCTAssertTrue(searchField.waitForExistence(timeout: 5))
        let cell = app.cells.firstMatch
        XCTAssertTrue(cell.waitForExistence(timeout: 5))

        searchField.doubleTap()
        searchField.typeText("\u{8}")
        searchField.typeText("Morty")
        let cell2 = app.cells.firstMatch
        XCTAssertTrue(cell2.waitForExistence(timeout: 5))
    }
    
    func testPaginationButtons() throws {
        let app = XCUIApplication()
        app.launch()

        let searchField = app.textFields["Search name"]
        XCTAssertTrue(searchField.waitForExistence(timeout: 5))
        searchField.doubleTap()
        searchField.typeText("\u{8}")
        searchField.typeText("Rick")

        let nextButton = app.buttons["Next"]
        let prevButton = app.buttons["Prev"]

        XCTAssertTrue(nextButton.waitForExistence(timeout: 5))
        nextButton.tap()

        // After tapping Next, Prev should exist (unless on last page)
        if prevButton.waitForExistence(timeout: 5) {
            prevButton.tap()
        }
    }
}
