//
//  My_HaircutUITests.swift
//  My HaircutUITests
//
//  Created by richard Haynes on 6/21/23.
//

import XCTest

final class My_HaircutUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSaveVisit() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        //let app = XCUIApplication()
        let verticalScrollBar1PageCollectionView = app/*@START_MENU_TOKEN@*/.collectionViews.containing(.other, identifier:"Vertical scroll bar, 1 page").element/*[[".collectionViews.containing(.other, identifier:\"Horizontal scroll bar, 1 page\").element",".collectionViews.containing(.other, identifier:\"Vertical scroll bar, 1 page\").element"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        verticalScrollBar1PageCollectionView.tap()
        
        let priceTextField = app.collectionViews/*@START_MENU_TOKEN@*/.textFields["Price"]/*[[".cells.textFields[\"Price\"]",".textFields[\"Price\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        priceTextField.tap()
        priceTextField.tap()
        
        app.collectionViews.staticTexts["Select All"].tap()
        priceTextField.typeText(XCUIKeyboardKey.delete.rawValue)
        priceTextField.typeText("10.00")
        verticalScrollBar1PageCollectionView.tap()
        app.collectionViews/*@START_MENU_TOKEN@*/.buttons["Save Visit"]/*[[".cells.buttons[\"Save Visit\"]",".buttons[\"Save Visit\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.alerts["Visit has been logged"].scrollViews.otherElements.buttons["OK"].tap()
        
                
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
