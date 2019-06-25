//
//  File.swift
//  GithubRepos
//
//  Created by Marinescu, Dragos-Victor V (UK - EDC) on 6/22/19.
//  Copyright © 2019 Marinescu, Dragos-Victor V (UK - EDC). All rights reserved.
//

import Foundation
import SwiftyJSON

// we use struct as it satisfies our needs and is way faster than class due to memory being allocated statically and NOT dynamically on the heap
struct Repo {
    var name: String?
    var language: String?
    var ownerAvatar: String?
    
    init(with json: JSON) {
        self.name = json["name"].string
        if let owner = json["owner"].dictionary, let avatar = owner["avatar_url"]?.string {
            self.ownerAvatar = avatar
        }
        self.language = json["language"].string
    }
    
    init(name: String, language: String, ownerAvatar: String) {
        self.name = name
        self.language = language
        self.ownerAvatar = ownerAvatar
    }
}
