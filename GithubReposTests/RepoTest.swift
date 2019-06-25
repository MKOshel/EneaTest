//
//  RepoTest.swift
//  GithubReposTests
//
//  Created by Marinescu, Dragos-Victor V (UK - EDC) on 6/25/19.
//  Copyright © 2019 Marinescu, Dragos-Victor V (UK - EDC). All rights reserved.
//

import XCTest
import SwiftyJSON
@testable import GithubRepos




class RepoTest: XCTestCase {
    
    var data: Dictionary<String, Any> = ["name": "BITCOIN",
                             "language": "has entered",
                             "ownerAvatar": "the bull market"]

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRepoInit() {
        XCTAssertNotNil(Repo(with: JSON(data)))
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
