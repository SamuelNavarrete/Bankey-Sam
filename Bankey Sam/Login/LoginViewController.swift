//
//  LoginViewController.swift
//  Bankey Sam
//
//  Created by Samuel Fuentes Navarrete on 30/01/23.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {

    var username: String? {
        return usernameTextField.text
    }

    var password: String? {
        return passwordTextField.text
    }
    
    private let titleLabel : UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.text = "Bankey"
        return titleLabel
    }()
    
    
    private let subtitleLabel : UILabel = {
        let subtitleLabel = UILabel()
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.textAlignment = .center
        subtitleLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        subtitleLabel.adjustsFontForContentSizeCategory = true
        subtitleLabel.numberOfLines = 0
        subtitleLabel.text = "Your premium source for all things banking!"
        return subtitleLabel
    }()
    
    
    private let contentView : UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .secondarySystemBackground
        contentView.layer.cornerRadius = 5
//        contentView.clipsToBounds = true
        return contentView
    }()
    
    
    private lazy var signInButton: UIButton = {
        let signInButton = UIButton(type: .system)
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.configuration = .filled()
        signInButton.configuration?.imagePadding = 8 // for indicator spacing
        signInButton.setTitle("Sign In", for: [])
        return signInButton
    }()
    
    
    private let errorMessageLabel : UILabel = {
        let errorMessageLabel = UILabel()
        errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        errorMessageLabel.textAlignment = .center
        errorMessageLabel.textColor = .systemRed
        errorMessageLabel.numberOfLines = 0
        errorMessageLabel.isHidden = true
        return errorMessageLabel
    }()
    
    
    private let stackView : UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    private let usernameTextField : UITextField = {
        let usernameTextField = UITextField()
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        usernameTextField.placeholder = "Username"
        return usernameTextField
    }()
    
    
    let passwordTextField : UITextField = {
        let passwordTextField = UITextField()
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.placeholder = "Password"
        passwordTextField.isSecureTextEntry = true
        return passwordTextField

    }()
    
    private let dividerView : UIView = {
        let dividerView = UIView()
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        dividerView.backgroundColor = .secondarySystemFill
        dividerView.layer.cornerRadius = 5
//        dividerView.clipsToBounds = true
        return dividerView
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        InitComponents()
    }
    
    override func viewDidAppear(_: Bool) {
        view.backgroundColor = UIColor(named: "ColorBackground")
    }
    
    
    func InitComponents(){
        AddComponets()
        SetLayout()
        SetTargets()
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        
    }
    
    private func AddComponets() {
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(contentView)
        view.addSubview(signInButton)
        view.addSubview(errorMessageLabel)
        
        
        stackView.addArrangedSubview(usernameTextField)
        stackView.addArrangedSubview(dividerView)
        stackView.addArrangedSubview(passwordTextField)

        contentView.addSubview(stackView)
    }
    
    
    
    func SetLayout(){
        
        dividerView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        NSLayoutConstraint.activate([
            
            // Title
            titleLabel.bottomAnchor.constraint(equalTo: subtitleLabel.topAnchor, constant: -10),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // Subtitle -- Different way to make a constraint
            contentView.topAnchor.constraint(equalToSystemSpacingBelow: subtitleLabel.bottomAnchor, multiplier: 3),
            subtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            // LoginView
            contentView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            contentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            
            // StackView
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            
            // Button -- Another different way to make a constraint
            signInButton.topAnchor.constraint(equalToSystemSpacingBelow: contentView.bottomAnchor, multiplier: 2),
            signInButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            signInButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            // Error message
            errorMessageLabel.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 10),
            errorMessageLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            errorMessageLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }

}


// MARK: Actions
extension LoginViewController {
    
    func SetTargets(){
        signInButton.addTarget(self, action: #selector(signInTapped), for: .primaryActionTriggered)

    }
    
    @objc func signInTapped(sender: UIButton) {
        errorMessageLabel.isHidden = true
        login()
    }
    
    private func login() {
        guard let username = username, let password = password else {
            assertionFailure("Username / password should never be nil")
            return
        }

        if username.isEmpty || password.isEmpty {
            configureView(withMessage: "Username / password cannot be blank")
            return
        }
        
        if username == "" && password == "" {
            signInButton.configuration?.showsActivityIndicator = true
        } else {
            configureView(withMessage: "Incorrect username / password")
        }
    }
    
    private func configureView(withMessage message: String) {
        errorMessageLabel.isHidden = false
        errorMessageLabel.text = message
    }
}




// MARK: Actions for UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        usernameTextField.endEditing(true)
        passwordTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
    }
}
