//
//  DummyViewController.swift
//  Bankey Sam
//
//  Created by Samuel Fuentes Navarrete on 31/01/23.
//

import Foundation
import UIKit

class DummyViewController: UIViewController{
    
    weak var delegateView : LoginView?
    
    private let stackView : UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        return stackView
    }()
    
    private let label : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Welcome"
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        return label
    }()
    
    private lazy var logoutButton: UIButton = {
        let logoutButton = UIButton(type: .system)
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.configuration = .filled()
        logoutButton.setTitle("Logout", for: [])
        return logoutButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        InitComponents()
    }
    
    override func viewDidAppear(_: Bool) {
    }
    
    
    func InitComponents(){
        AddComponets()
        SetLayout()
        SetTargets()
    }
    
    func AddComponets(){
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(logoutButton)
    }
    
    func SetLayout(){
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
}

extension DummyViewController{
    func SetTargets(){
        logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .primaryActionTriggered)
    }

    
    @objc func logoutButtonTapped(sender: UIButton){
        delegateView?.didLogout()
    }
}
