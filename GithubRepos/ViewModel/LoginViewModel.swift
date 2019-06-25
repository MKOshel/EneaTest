//
//  LoginViewModel.swift
//  GithubRepos
//
//  Created by Marinescu, Dragos-Victor V (UK - EDC) on 6/22/19.
//  Copyright © 2019 Marinescu, Dragos-Victor V (UK - EDC). All rights reserved.
//

import RxSwift

class LoginViewModel: ViewModelProtocol {
    
    struct Input {
        let email: AnyObserver<String>
        let password: AnyObserver<String>
        let signInDidTap: AnyObserver<Void>
    }
    struct Output {
        let loginResultObservable: Observable<User>
        let errorsObservable: Observable<Error>
    }
    
    let input: Input
    let output: Output
    
    //subjects
    private let usernameSubject = PublishSubject<String>()
    private let passwordSubject = PublishSubject<String>()
    private let signInDidTapSubject = PublishSubject<Void>()
    private let loginResultSubject = PublishSubject<User>()
    private let errorsSubject = PublishSubject<Error>()
    private let disposeBag = DisposeBag()
    
    // get input from user and combine to Credentials instance
    private var credentialsObservable: Observable<Credentials> {
        return Observable.combineLatest(usernameSubject.asObservable(), passwordSubject.asObservable()) { (username, password) in
            return Credentials(username: username, password: password)
        }
    }
    
    //dependency injection via protocol
    init(_ loginService: LoginServiceProtocol) {
                
        input = Input(email: usernameSubject.asObserver(),
                      password: passwordSubject.asObserver(),
                      signInDidTap: signInDidTapSubject.asObserver())
        
        output = Output(loginResultObservable: loginResultSubject.asObservable(),
                        errorsObservable: errorsSubject.asObservable())
        
        //action for login btn tapped that passes credentials to call
        signInDidTapSubject
            .withLatestFrom(credentialsObservable)
            .flatMapLatest { credentials in
                return loginService.signIn(with: credentials).materialize()
            }
            .subscribe(onNext: { [weak self] event in // capture self as weak reference in order to avoid memory leaks 
                switch event {
                case .next(let user):
                    self?.loginResultSubject.onNext(user)
                case .error(let error):
                    self?.errorsSubject.onNext(error)
                default:
                    break
                }
            })
            .disposed(by: disposeBag)
    }
}
