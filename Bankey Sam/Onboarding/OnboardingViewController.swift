//
//  OnboardingViewController.swift
//  Bankey Sam
//
//  Created by Samuel Fuentes Navarrete on 30/01/23.
//

import Foundation

import UIKit

class OnboardingViewController: UIViewController {
    
    let heroImageName: String
    let titleText: String
    
    
    let stackView : UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        return stackView
    }()
    
    let heroImageView : UIImageView = {
        let heroImageView = UIImageView()
        heroImageView.translatesAutoresizingMaskIntoConstraints = false
        heroImageView.contentMode = .scaleAspectFit
        return heroImageView
    }()
    
    
    let titleLabel : UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.numberOfLines = 0
        return titleLabel
    }()
    
   
    init(heroImageName: String, titleText: String) {
        self.heroImageName = heroImageName
        self.titleText = titleText
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented - not using storyboards")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        InitComponets()
    }
    
    override func viewDidAppear(_: Bool) {
        view.backgroundColor = .systemBackground
    }
    
    
    func InitComponets() {
        AddComponets()
        SetLayout() 
        heroImageView.image = UIImage(named: heroImageName)
        titleLabel.text = titleText
    }
    

    func AddComponets(){
        stackView.addArrangedSubview(heroImageView)
        stackView.addArrangedSubview(titleLabel)
        
        view.addSubview(stackView)
    }
       
        
    func SetLayout() {
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 1)
        ])
    }
}



