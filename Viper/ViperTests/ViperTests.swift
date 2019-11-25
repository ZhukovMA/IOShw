//
//  ViperTests.swift
//  ViperTests
//
//  Created by Максим Жуков on 25/11/2019.
//  Copyright © 2019 Максим Жуков. All rights reserved.
//

import XCTest
@testable import Viper

class ViperTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testUrl() {
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

}

extension ViperTests {
    class MockUrlSession: URLSessionProtocol {
        var url: URL?
        func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            self.url = url
            return URLSession.shared.dataTask(with: url)
        }
    }
}
