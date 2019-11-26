//
//  ViperTests.swift
//  ViperTests
//
//  Created by Максим Жуков on 25/11/2019.
//  Copyright © 2019 Максим Жуков. All rights reserved.
//

import XCTest
@testable import Viper

class PresenterTests: XCTestCase {
    var presenter : Presenter!
    var viewController: ViewControllerSupport!
    var interactor : InteractorSupport!
    override func setUp() {
        super.setUp()
        presenter = Presenter()
        viewController = ViewControllerSupport()
        interactor = InteractorSupport()
    }
    
    override func tearDown() {
        presenter = nil
        viewController = nil
        interactor = nil
        super.tearDown()
    }

    
    func testThatCheckValidDataInNotifyAboutClearCash() {
        // arrange
        presenter.output = viewController
        
        // act
        presenter.notifyAboutClearCash()
        
        // assert
        XCTAssertNotEqual(viewController.text, "", "")
    }
    
    func testThatCheckValidDataInNotifyAboutDownload() {
        // arrange
        presenter.output = viewController
        
        // act
        presenter.notifyAboutDownload(data: nil)
        
        // assert
        XCTAssertNotEqual(viewController.text, "", "")
    }
    
    func testThatCheckValueCallGetImageFromCash() {
        // arrange
        presenter.output = viewController
        
        // act
        presenter.getImageFromCash()
        
        // assert
        XCTAssertEqual(1, viewController.clearCashCounter, "Количество вызовов не равно 1")
        
    }
    
    func testThatCheckValueCallClearCash() {
        // arrange
        presenter.interactor = interactor
        
        // act
        presenter.clearCash()
        
        // assert
        XCTAssertEqual(1, interactor.clearCashCounter, "Количество вызовов не равно 1")

    }
}


