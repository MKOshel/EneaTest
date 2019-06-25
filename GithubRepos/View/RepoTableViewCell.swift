//
//  RepoTableViewCell.swift
//  GithubRepos
//
//  Created by Marinescu, Dragos-Victor V (UK - EDC) on 6/24/19.
//  Copyright © 2019 Marinescu, Dragos-Victor V (UK - EDC). All rights reserved.
//

import Foundation
import UIKit

class RepoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelLanguage: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
