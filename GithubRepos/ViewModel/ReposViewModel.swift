//
//  ReposViewModel.swift
//  GithubRepos
//
//  Created by Marinescu, Dragos-Victor V (UK - EDC) on 6/22/19.
//  Copyright © 2019 Marinescu, Dragos-Victor V (UK - EDC). All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa


class ReposViewModel {
    
    enum RepoCellResultType {
        case loaded(repoCellModel: RepoCellModel)
        case error(message: String)
    }
    
    let repoService: ReposService
    let disposeBag = DisposeBag()
    
    var repoCells: Observable<[RepoCellResultType]> {
        return cells.asObservable()
    }
    
    private let cells = BehaviorRelay<[RepoCellResultType]>(value: [])

    //dependency injection
    init(reposService: ReposService) {
        self.repoService = reposService
    }

    func getRepos()  {
        repoService.getRepos().subscribe(
                onNext: { [weak self] repos in
                    self?.cells.accept(repos.compactMap { .loaded(repoCellModel: RepoCellModel(repo: $0 )) })
                },
                onError: { [weak self] error in
                    self?.cells.accept([
                        .error(
                            message: (error.localizedDescription))
                      ])
                 }
            )
            .disposed(by: disposeBag)
    }
}
