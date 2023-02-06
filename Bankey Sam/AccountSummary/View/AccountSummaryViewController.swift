//
//  AccountSummaryViewController.swift
//  Bankey Sam
//
//  Created by Samuel Fuentes Navarrete on 02/02/23.
//

import Foundation
import UIKit

class AccountSummaryViewController: UIViewController{
    
//    let games = [
//        "Pacman",
//        "Space Invaders",
//        "Space Patrol",
//    ]
    //var viewModel: AccountSummaryViewModel?

    
    var accounts: [AccountSumary] = []
    
    lazy var logoutBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutTapped))
        barButtonItem.tintColor = .label
        return barButtonItem
    }()

    
    private let tableView : UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(AccountSummaryCell.self, forCellReuseIdentifier: AccountSummaryCell.reuseID)
        tableView.rowHeight = AccountSummaryCell.rowHeight
        tableView.backgroundColor = appColor
        tableView.tableFooterView = UIView()
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
        FetchData()
        setupNavigationBar()
    }
    
    func AddComponets(){
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setupNavigationBar() {
        navigationItem.rightBarButtonItem = logoutBarButtonItem
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
        
        guard !accounts.isEmpty else { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: AccountSummaryCell.reuseID, for: indexPath) as! AccountSummaryCell
        let account = accounts[indexPath.row]
        cell.configure(with: account)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accounts.count
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


extension AccountSummaryViewController {
    private func FetchData() {
        
        let savings = AccountSumary(accountType: .Banking,accountName: "Basic Savings", balance: 929466.23)
        let chequing = AccountSumary(accountType: .Banking, accountName: "No-Fee All-In Chequing", balance: 17562.44)
        let visa = AccountSumary(accountType: .CreditCard,accountName: "Visa Avion Card", balance: 412.83)
        let masterCard = AccountSumary(accountType: .CreditCard, accountName: "Student Mastercard", balance: 50.83)
        let investment1 = AccountSumary(accountType: .Investment, accountName: "Tax-Free Saver", balance: 2000.00)
        let investment2 = AccountSumary(accountType: .Investment,accountName: "Growth Fund", balance: 15000.00)

        accounts.append(savings)
        accounts.append(chequing)
        accounts.append(visa)
        accounts.append(masterCard)
        accounts.append(investment1)
        accounts.append(investment2)
    }
}


extension AccountSummaryViewController {
    func SetTargets(){
    }

    
    @objc func logoutTapped(sender: UIButton){
        NotificationCenter.default.post(name: .logout, object: nil)
    }
}
