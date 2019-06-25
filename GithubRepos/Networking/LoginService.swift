//
//  LoginService.swift
//  GithubRepos
//
//  Created by Marinescu, Dragos-Victor V (UK - EDC) on 6/22/19.
//  Copyright © 2019 Marinescu, Dragos-Victor V (UK - EDC). All rights reserved.
//

import Foundation
import RxSwift
import Alamofire
import SwiftyJSON


protocol LoginServiceProtocol {
    func signIn(with credentials: Credentials) -> Observable<User>
}


class LoginService: LoginServiceProtocol {
        
    func signIn(with credentials: Credentials) -> Observable<User> {
        return Observable.create { observer in
            
            var headers: HTTPHeaders = [
                "Accept": "application/vnd.github.v3+json"
            ]
            if let authorizationHeader = Request.authorizationHeader(user: credentials.username, password: credentials.password) {
                headers[authorizationHeader.key] = authorizationHeader.value
            }
            
            let loginEndpoint = Endpoint(path: "/user", queryItems: nil)
            
            if let url  = loginEndpoint.url {
                let request = Alamofire.request(url, headers: headers)
                request.response { response in
                    if let data = response.data {
                        
                        if let json = try? JSON(data:data) {
                            let user = User.init(with: json)
                                if let name = user.name, !name.isEmpty  {
                                observer.onNext(user)
                                User.saveToDefaults(user: user)
                            } else {
                                /////// because the response always returns success code we need to handle error appropiately
                                let error: Error = LoginError.invalidUserOrPassword
                                observer.onError(error)
                                ////////
                            }
                        }
                    } else if let error = response.error {
                        debugPrint("Failed to get: \(url)")
                        observer.onError(error)
                    }
                }
            }
            return Disposables.create()
        }
    }
}

