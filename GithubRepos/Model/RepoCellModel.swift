//
//  File.swift
//  GithubRepos
//
//  Created by Marinescu, Dragos-Victor V (UK - EDC) on 6/25/19.
//  Copyright © 2019 Marinescu, Dragos-Victor V (UK - EDC). All rights reserved.
//

import Foundation

struct RepoCellModel {
    let name: String?
    let language: String?
    let ownerAvatar: String?
}

extension RepoCellModel {
    init(repo: Repo) {
        self.name = repo.name
        self.language = repo.language
        self.ownerAvatar = repo.ownerAvatar
    }
}
