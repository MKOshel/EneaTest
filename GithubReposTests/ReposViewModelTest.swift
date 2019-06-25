//
//  ReposViewModelTest.swift
//  GithubReposTests
//
//  Created by Marinescu, Dragos-Victor V (UK - EDC) on 6/25/19.
//  Copyright © 2019 Marinescu, Dragos-Victor V (UK - EDC). All rights reserved.
//

import XCTest
import RxSwift
@testable import GithubRepos


class ReposViewModelTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testLoadedWithSuccessRepoCells() {
        let disposeBag = DisposeBag()
        let apiService = MockRepoService()
        
        //mock Repo and simulate succesful network fetch
        apiService.getReposResult = .success(payload: [Repo(name: "repo", language: "lang", ownerAvatar: "avatar")])
        
        let viewModel = ReposViewModel(reposService: apiService)
        viewModel.getRepos()
        
        let expectRepoCellLoadedCorrectly = expectation(description: "RepoCellLoadedCorrectly")
        
        //we check table view cell state
        viewModel.repoCells.subscribe(
            onNext: {
                let firstCellIsLoaded: Bool
                
                if case.some(.loaded(_)) = $0.first {
                    firstCellIsLoaded = true
                } else {
                    firstCellIsLoaded = false
                }
                
                XCTAssertTrue(firstCellIsLoaded)
                expectRepoCellLoadedCorrectly.fulfill()
        }
            ).disposed(by: disposeBag)
        
        wait(for: [expectRepoCellLoadedCorrectly], timeout: 0.1)
    }

}

class MockRepoService: ReposService {
    var getReposResult: Result<[Repo], ReposService.GetReposFailureReason >?

    //create observer & override getRepos() in order to simulate network fetch with different results with the help of getRepoResult
    override func getRepos() -> Observable<[Repo]> {
        return Observable.create { observer in
            switch self.getReposResult {
            case .success(let friends)?:
                observer.onNext(friends)
            case .failure(let error)?:
                observer.onError(error!)
            case .none:
                observer.onError(ReposService.GetReposFailureReason.notFound)
            }
            
            return Disposables.create() //dummy disposable
        }
    }
}

//generic for sim network result
enum Result<T, U: Error> {
    case success(payload: T)
    case failure(U?)
}
