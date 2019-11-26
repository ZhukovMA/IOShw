//
//  ViperTests.swift
//  ViperTests
//
//  Created by Максим Жуков on 25/11/2019.
//  Copyright © 2019 Максим Жуков. All rights reserved.
//

import XCTest
@testable import Viper

class InteractorTests: XCTestCase {
    var interactor : Interactor!
    var presenter : PresenterSupport!
    
    override func setUp() {
        super.setUp()
        interactor = Interactor()
        presenter = PresenterSupport()
    }

    override func tearDown() {
        interactor = nil
        presenter = nil
        super.tearDown()
    }
    
    func testThatCheckValidUrl() {
        let mockUrlSession = MockUrlSession()
        let interactor = Interactor()
        interactor.urlSession = mockUrlSession
        let completion = {(data: Data?, error: Error?) in}
        interactor.getData(completion: completion)
        
        guard let url = mockUrlSession.url else {
            XCTFail()
            return
        }
        XCTAssertEqual(url, URL(string: "http://icons.iconarchive.com/icons/dtafalonso/ios8/512/Calendar-icon.png"))
    }

    func testThatCanClearCacheInInteractor() {
        
        // arrange
        interactor.output = presenter
        interactor.cash = Data()
        
        // act
        interactor.clearCash()
        
        // assert
        XCTAssertNil(presenter.cash, "Кэш не очистился")
        
    }
    
}

extension InteractorTests {
    class MockUrlSession: URLSessionProtocol {
        var url: URL?
        func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            self.url = url
            return URLSession.shared.dataTask(with: url)
        }
    }
}
