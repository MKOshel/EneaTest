//
//  ViewModelType.swift
//  GithubRepos
//
//  Created by Marinescu, Dragos-Victor V (UK - EDC) on 6/22/19.
//  Copyright © 2019 Marinescu, Dragos-Victor V (UK - EDC). All rights reserved.
//

import Foundation


/// Input, should subscribe to UI elements that send events
/// Output, observables that emit events based on the input

protocol ViewModelProtocol: class {
    associatedtype Input
    associatedtype Output
}
