//
//  ReposService.swift
//  GithubRepos
//
//  Created by Marinescu, Dragos-Victor V (UK - EDC) on 6/22/19.
//  Copyright © 2019 Marinescu, Dragos-Victor V (UK - EDC). All rights reserved.
//

import Foundation
import RxSwift
import Alamofire
import SwiftyJSON


class ReposService {
    
    enum GetReposFailureReason: Int, Error {
        case unAuthorized = 401
        case notFound = 404
    }
    
    
    func getRepos() -> Observable<[Repo]> {
        
        return Observable.create { observer -> Disposable in
            
            let user = User.getFromDefaults()
            let reposEndpoint = Endpoint(path: "/users/\(user?.name ?? "")/repos",
                queryItems: [URLQueryItem(name: "per_page", value:"\(10)")])
            
            if let url = reposEndpoint.url {
                
                let request = Alamofire.request(url)
                
                request.response { response in
                    if let data = response.data {
                        if let json = try? JSON(data:data) {
                            // parse json repo array and return repo collection without nil results with the help of compactMap
                            if let repos = json.array?.compactMap(Repo.init) {
                                observer.onNext(repos)
                            } else {
                                let error: Error = DataError.jsonError
                                observer.onError(error)
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
