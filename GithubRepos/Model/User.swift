//
//  User.swift
//  GithubRepos
//
//  Created by Marinescu, Dragos-Victor V (UK - EDC) on 6/22/19.
//  Copyright © 2019 Marinescu, Dragos-Victor V (UK - EDC). All rights reserved.
//

import Foundation
import SwiftyJSON

let userKey = "userKey"

struct User: Codable {
    var name: String?
    var publicRepos: Int?
    
    init(with json: JSON) {
        self.name = json["login"].stringValue
        self.publicRepos = json["public_repos"].int
    }
    
    static func saveToDefaults(user: User) {
        UserDefaults.standard.set(try! PropertyListEncoder().encode(user), forKey: userKey)
    }
    
    static func getFromDefaults() -> User? {
        if let data = UserDefaults.standard.object(forKey: userKey) as? Data {
            let storedUser: User = try! PropertyListDecoder().decode(User.self, from: data)
            
            return storedUser
        }
        return nil
    }
}
