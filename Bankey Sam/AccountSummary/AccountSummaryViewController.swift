//
//  AccountSummaryViewController.swift
//  Bankey Sam
//
//  Created by Samuel Fuentes Navarrete on 02/02/23.
//

import Foundation
import UIKit

class AccountSummaryViewController: UIViewController{
    
    let games = [
        "Pacman",
        "Space Invaders",
        "Space Patrol",
    ]
    
    private let tableView : UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        InitComponents()
    }
    
    override func viewDidAppear(_: Bool) {
        //view.backgroundColor = .systemGreen
    }
    
    
    func InitComponents(){
        AddComponets()
        SetLayout()
        setupTableHeaderView()
    }
    
    func AddComponets(){
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func SetLayout(){
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    
    
    
    private let stackContainerHeader : UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.alignment = .top
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    
    private let stackContainerOfStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        //stack.distribution = .fillProportionally
        //stack.alignment = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let Image: UIImageView = {
        let termsImage = UIImageView(image: UIImage(named: "sun_max"))
        termsImage.translatesAutoresizingMaskIntoConstraints = false
        termsImage.contentMode = .scaleAspectFit
        return termsImage
    }()
    
    private func setupTableHeaderView() {
        let header = UIView(frame: .zero)
        //header.frame.size.width = UIScreen.main.bounds.width
        header.frame.size.height = 150
        header.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        header.backgroundColor = appColor
            
        tableView.tableHeaderView = header
        
        header.addSubview(stackContainerOfStack)
        
        stackContainerOfStack.addArrangedSubview(stackContainerHeader)
        stackContainerOfStack.addArrangedSubview(Image)
        
        
        
        NSLayoutConstraint.activate([
            
//            Image.widthAnchor.constraint(equalToConstant: 100),
//            Image.heightAnchor.constraint(equalToConstant: 100),
//
            
            stackContainerOfStack.topAnchor.constraint(equalTo: header.topAnchor, constant: 10),
            stackContainerOfStack.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: 10),
            stackContainerOfStack.trailingAnchor.constraint(equalTo: header.trailingAnchor, constant: -10),
            stackContainerOfStack.bottomAnchor.constraint(equalTo: header.bottomAnchor, constant: -10)
        ])
        
        createList()
    }
    
    
}

extension AccountSummaryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = games[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
}

extension AccountSummaryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let viewHeader = AccountSummaryHeaderView()
//        viewHeader.backgroundColor = UIColor.red
//        return viewHeader
//    }
}


extension AccountSummaryViewController{
    
    
    
    
   
    
    func createList() {
        let ListData : [UIView] = []
        
        var views: [()] = ListData.map{_ in listView(text: "", namefont: "", size: 0)}

        //ListData.insert(listView(text: "Paga desde cualquier lugar."), at: data.startIndex)
        views.append(listView(text: "Bankey", namefont: "Title 1", size: 30))
        views.append(listView(text: "Good morning,", namefont: "Title 3", size: 20))
        views.append(listView(text: "Jonathan", namefont: "Title 3", size: 20))
        views.append(listView(text: "Date", namefont: "Subhead", size: 20))
//        views.append(listView(text: "Sin costo de comisión."))
    }
    
    func listView(text: String, namefont: String, size: CGFloat)  {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillProportionally
//        stack.alignment = .fill
        stack.spacing = 0
        
        let DataLabel = UILabel ()
        DataLabel.text = text
        DataLabel.numberOfLines = 0
        //DataLabel.font = Fonts.SFProBook.of(size: size)
        //DataLabel.font = UIFont(name: namefont, size: size - 1)
        DataLabel.font = GetType(size: size - 1, TypeFont: namefont)
        
        

        
        stack.addArrangedSubview(DataLabel)
        
        stackContainerHeader.addArrangedSubview(stack)
    }
}

