//
//  LoginViewController.swift
//  GithubRepos
//
//  Created by Marinescu, Dragos-Victor V (UK - EDC) on 6/22/19.
//  Copyright © 2019 Marinescu, Dragos-Victor V (UK - EDC). All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var textFieldUsername: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var btnLogin: UIButton!
    
    var viewModel = LoginViewModel(LoginService())
    private let disposeBag = DisposeBag() //calls dispose on each of the disposables to free memory
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure(with: viewModel)
    }
    
    func stopActivity() {
        activityIndicator.stopAnimating()
    }
    
    func configure(with viewModel: LoginViewModel) {
        
        textFieldUsername.rx.text.asObservable()
            .ignoreNil()
            .subscribe(viewModel.input.email)
            .disposed(by: disposeBag)
        
        textFieldPassword.rx.text.asObservable()
            .ignoreNil()
            .subscribe(viewModel.input.password)
            .disposed(by: disposeBag)
        
        btnLogin.rx.tap.asObservable()
            .subscribe(viewModel.input.signInDidTap)
            .disposed(by: disposeBag)
        
        viewModel.output.errorsObservable
            .subscribe(onNext: { [weak self] (error) in
                self?.presentError(error)
                self?.stopActivity()
            })
            .disposed(by: disposeBag)
        
        viewModel.output.loginResultObservable
            .subscribe(onNext: { [weak self] (user) in
                self?.presentReposViewController()
            })
            .disposed(by: disposeBag)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let reposVC = segue.destination as? ReposViewController {
            let service = ReposService()
            reposVC.viewModel = ReposViewModel(reposService: service)
        }
    }

}

extension UIViewController {
    func presentError(_ error: Error) {
        let alertController = UIAlertController(title: "Error",
                                                message: error.localizedDescription,
                                                preferredStyle: .alert)
        alertController.addAction(.init(title: "OK", style: .default))
        self.present(alertController, animated: true)
    }
    
    func presentReposViewController() {
        self.performSegue(withIdentifier: "reposSegue", sender: nil)
    }
}


