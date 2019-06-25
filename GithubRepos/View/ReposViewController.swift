//
//  ReposViewController.swift
//  GithubRepos
//
//  Created by Marinescu, Dragos-Victor V (UK - EDC) on 6/22/19.
//  Copyright © 2019 Marinescu, Dragos-Victor V (UK - EDC). All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import AlamofireImage
import Alamofire

class ReposViewController: UIViewController {
    
    @IBOutlet weak var reposTableView: UITableView!
    
    var viewModel: ReposViewModel?
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        title = "GitHub Repos"
        navigationController?.navigationBar.prefersLargeTitles = true

        reposTableView.register(UINib(nibName: "RepoTableViewCell", bundle: nil), forCellReuseIdentifier: "repoCell")
        
        if let repoViewModel = viewModel {
            repoViewModel.getRepos()
            configure(with: repoViewModel)
        }
        
    }
    
    func configure(with viewModel: ReposViewModel) {
        
        //tableView setup based on repoCellModel
        viewModel.repoCells.bind(to: reposTableView.rx.items(cellIdentifier: "repoCell", cellType: RepoTableViewCell.self)) { row, repoCellModel, cell in
            
            switch repoCellModel {
            case .loaded(let repo):
                cell.labelName.text = repo.name
                cell.labelLanguage.text = repo.language
                
                if let avatarURLstring = repo.ownerAvatar {
                    Alamofire.request(avatarURLstring).responseImage { response in
                        if let image = response.result.value {
                            cell.avatar.image = image
                        }
                    }
                }
            case .error(let message):
                cell.labelName.text = message
            }
            
        }.disposed(by: disposeBag)
    }
}
