//
//  CosmoCuriosityAppUITests.swift
//  CosmoCuriosityAppUITests
//
//  Created by Artur Drohobytskyy on 07/05/2025.
//

import XCTest

final class APODUITests: XCTestCase {
    private var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func testTabNavigation() throws {
        XCTAssertTrue(app.staticTexts["Picture of the day"].exists)

        app.tabBars.buttons["Mars"].tap()
        XCTAssertTrue(app.staticTexts["Mars Rover"].exists)

        app.tabBars.buttons["Earth"].tap()
        XCTAssertTrue(app.staticTexts["Earth View"].exists)

        app.tabBars.buttons["Search"].tap()
        XCTAssertTrue(app.staticTexts["NASA Search"].exists)

        app.tabBars.buttons["Favorites"].tap()
        XCTAssertTrue(app.staticTexts["Favorites"].exists)
    }

    func testFavoriteAPOD() throws {
        app.tabBars.buttons["Home"].tap()

        let firstCell = app.scrollViews.children(matching: .other).firstMatch
        XCTAssertTrue(firstCell.waitForExistence(timeout: 5))
        firstCell.tap()

        let favoriteButton = app.buttons["FavoriteButton"]
        XCTAssertTrue(favoriteButton.waitForExistence(timeout: 5))
        favoriteButton.tap()

        XCTAssertTrue(favoriteButton.isHittable)
    }

    func testShareAPOD() throws {
        app.tabBars.buttons["Home"].tap()

        let firstCell = app.scrollViews.children(matching: .other).firstMatch
        XCTAssertTrue(firstCell.waitForExistence(timeout: 5))
        firstCell.tap()

        let shareButton = app.buttons["ShareButton"]
        XCTAssertTrue(shareButton.waitForExistence(timeout: 5))
        shareButton.tap()
    }

    func testScrollAndLoadMoreAPODs() throws {
        app.tabBars.buttons["Home"].tap()

        let scrollView = app.scrollViews.firstMatch
        XCTAssertTrue(scrollView.waitForExistence(timeout: 5))

        scrollView.swipeUp()
        scrollView.swipeUp()
        scrollView.swipeUp()
    }
}

final class MarsUITests: XCTestCase {
    private var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
        app.tapTab("Mars")
    }

    func testMarsPhotosLoadsAfterDateSelection() throws {
        app.tapDatePicker()
        let firstDayOfTheMonthIndex = 10
        let dayButton = app.buttons.element(boundBy: firstDayOfTheMonthIndex)
        if dayButton.waitForExistence(timeout: 5) {
            dayButton.tap()
        }
        let firstImage = app.images.firstMatch
        XCTAssertTrue(firstImage.waitForExistence(timeout: 5))
    }
}

final class EPICUITests: XCTestCase {
    private var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
        app.tabBars.buttons["Earth"].tap()
    }

    func testEPICImagesAppear() throws {
        XCTAssertTrue(app.staticTexts["Earth View"].waitForExistence(timeout: 5))

        let firstImage = app.images.firstMatch
        XCTAssertTrue(firstImage.waitForExistence(timeout: 5))
    }
}

final class SearchUITests: XCTestCase {
    private var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
        app.tabBars.buttons["Search"].tap()
    }

    func testSearchFunctionality() throws {
        let textField = app.textFields.firstMatch
        XCTAssertTrue(textField.waitForExistence(timeout: 5))

        textField.tap()
        textField.typeText("moon\n")

        let firstImage = app.images.firstMatch
        XCTAssertTrue(firstImage.waitForExistence(timeout: 5))
    }
}

final class FavoritesUITests: XCTestCase {
    private var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
        app.tabBars.buttons["Favorites"].tap()
    }

    func testFavoritesViewLoads() throws {
        XCTAssertTrue(app.staticTexts["Favorites"].waitForExistence(timeout: 5))
    }
}

extension XCUIApplication {
    
    /// Selects a date on a `DatePicker`
    /// - Parameter date: The `Date` to pick
    func tapDatePicker() {
        let datePicker = datePickers.firstMatch
        guard datePicker.waitForExistence(timeout: 5) else {
            XCTFail("DatePicker not found")
            return
        }
        datePicker.tap()
    }
    
    /// Taps a tab by its label name
    /// - Parameter tabName: The title of the tab
    func tapTab(_ tabName: String) {
        let tabButton = tabBars.buttons[tabName]
        guard tabButton.waitForExistence(timeout: 5) else {
            XCTFail("Tab '\(tabName)' not found")
            return
        }
        
        tabButton.tap()
    }
    
    /// Taps the first visible cell (like a card or a list item)
    func tapFirstCard() {
        let firstCell = scrollViews.children(matching: .other).firstMatch
        guard firstCell.waitForExistence(timeout: 5) else {
            XCTFail("First card not found")
            return
        }
        
        firstCell.tap()
    }
}
