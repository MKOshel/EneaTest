//
//  ObservableExtension.swift
//  GithubRepos
//
//  Created by Marinescu, Dragos-Victor V (UK - EDC) on 6/24/19.
//  Copyright © 2019 Marinescu, Dragos-Victor V (UK - EDC). All rights reserved.
//

import Foundation
import RxSwift

/* for the purpose of ignoring nil input */
public protocol OptionalType {
    associatedtype Wrapped
    
    var optional: Wrapped? { get }
}

extension Optional: OptionalType {
    public var optional: Wrapped? { return self }
}

extension Observable where Element: OptionalType {
    func ignoreNil() -> Observable<Element.Wrapped> {
        return flatMap { value in
            value.optional.map { Observable<Element.Wrapped>.just($0) } ?? Observable<Element.Wrapped>.empty()
        }
    }
}
