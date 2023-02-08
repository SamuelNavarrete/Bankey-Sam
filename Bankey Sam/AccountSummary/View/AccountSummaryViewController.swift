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

    var accounts: [Account] = []
    
    let shakeyBellView = ShakeyBellView()
    
    var accountsDataCell: [AccountSumary] = []
    
    var headerViewModel = DataAccountHeader(welcomeMessage: "Welcome", name: "", date: Date())
    
    var dataHeader : DataAccountHeader?
    var profile : Profile?
    
    var accountSummaryRepositoryImpl = AccountSummaryRepositoryImpl()
    
    var profileManager: ProfileManageable = AccountSummaryRepositoryImpl()
    
    var header = UIView(frame: .zero)
    let stack = UIStackView()
    let BankeyLabel = UILabel ()
    let GreetingLabel = UILabel ()
    let NameLabel = UILabel ()
    let DateLabel = UILabel ()

    let refreshControl = UIRefreshControl()

    var isLoaded = false

    
    lazy var errorAlert: UIAlertController = {
        let alert =  UIAlertController(title: "", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        return alert
    }()
    
    lazy var logoutBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutTapped))
        barButtonItem.tintColor = .label
        return barButtonItem
    }()

    
    private let tableView : UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(AccountSummaryCell.self, forCellReuseIdentifier: AccountSummaryCell.reuseID)
        tableView.register(SkeletonCell.self, forCellReuseIdentifier: SkeletonCell.reuseID)
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
        setupNavigationBar()
        setupRefreshControl()
        AddComponets()
        SetLayout()
        setupTableHeaderView()
        //FetchAccounts()
        fetchData()
        setupSkeletons()
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
    
    
//    private let stackContainerHeader : UIStackView = {
//        let stack = UIStackView()
//        stack.axis = .vertical
//        stack.distribution = .fillProportionally
//        stack.alignment = .top
//        stack.translatesAutoresizingMaskIntoConstraints = false
//        return stack
//    }()
    
    
    private let stackContainerOfStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.alignment = .top
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
        
        //header.frame.size.width = UIScreen.main.bounds.width
        header.frame.size.height = 150
        header.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        header.backgroundColor = appColor
            
        tableView.tableHeaderView = header
        
        header.addSubview(stackContainerOfStack)
        
        //stackContainerOfStack.addArrangedSubview(stackContainerHeader)
        stackContainerOfStack.addArrangedSubview(stack)
        stackContainerOfStack.addArrangedSubview(Image)
        
        header.addSubview(shakeyBellView)
        
        shakeyBellView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            
//            Image.widthAnchor.constraint(equalToConstant: 100),
//            Image.heightAnchor.constraint(equalToConstant: 100),

            stackContainerOfStack.topAnchor.constraint(equalTo: header.topAnchor, constant: 10),
            stackContainerOfStack.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: 10),
            stackContainerOfStack.trailingAnchor.constraint(equalTo: header.trailingAnchor, constant: -10),
            stackContainerOfStack.bottomAnchor.constraint(equalTo: header.bottomAnchor, constant: -10),
            
            
            shakeyBellView.trailingAnchor.constraint(equalTo: header.trailingAnchor),
            shakeyBellView.bottomAnchor.constraint(equalTo: header.bottomAnchor)
        ])
        
        HeaderTableView()
    }
    
    
    
    private func setupRefreshControl() {
        refreshControl.tintColor = appColor
        refreshControl.addTarget(self, action: #selector(refreshContent), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    
    private func setupSkeletons() {
        let row = Account.makeSkeleton()
        accounts = Array(repeating: row, count: 10)
        
        configureTableCells(with: accounts)
    }
    
}

extension AccountSummaryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard !accountsDataCell.isEmpty else { return UITableViewCell() }
        let account = accountsDataCell[indexPath.row]

        if isLoaded {
            let cell = tableView.dequeueReusableCell(withIdentifier: AccountSummaryCell.reuseID, for: indexPath) as! AccountSummaryCell
            cell.configure(with: account)
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SkeletonCell.reuseID, for: indexPath) as! SkeletonCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accountsDataCell.count
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
    
    func HeaderTableView()  {
        
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.alignment = .fill
        stack.spacing = 0
        
        BankeyLabel.numberOfLines = 0
        BankeyLabel.font = GetType(size: 30 - 1, TypeFont: "Title 1")
        BankeyLabel.text = "Bankey"
        
        GreetingLabel.numberOfLines = 0
        GreetingLabel.font = GetType(size: 20 - 1, TypeFont: "Title 3")
        GreetingLabel.text = "Good morni"

        
        NameLabel.numberOfLines = 0
        NameLabel.font = GetType(size: 20 - 1, TypeFont: "Title 3")
        NameLabel.text = "Stevie"

        
        DateLabel.numberOfLines = 0
        DateLabel.font = GetType(size: 20 - 1, TypeFont: "Subhead")
        DateLabel.text = "Date"

        
        stack.addArrangedSubview(BankeyLabel)
        stack.addArrangedSubview(GreetingLabel)
        stack.addArrangedSubview(NameLabel)
        stack.addArrangedSubview(DateLabel)
    }
    
    
    func configure(dataAccount: DataAccountHeader) {
            self.GreetingLabel.text = dataAccount.welcomeMessage
            self.NameLabel.text = dataAccount.name
            self.DateLabel.text = dataAccount.dateFormatted
    }
    
}


//extension AccountSummaryViewController {
//
//    private func FetchAccounts() {
//
//        let savings = AccountSumary(accountType: .Banking,accountName: "Basic Savings", balance: 929466.23)
//        let chequing = AccountSumary(accountType: .Banking, accountName: "No-Fee All-In Chequing", balance: 17562.44)
//        let visa = AccountSumary(accountType: .CreditCard,accountName: "Visa Avion Card", balance: 412.83)
//        let masterCard = AccountSumary(accountType: .CreditCard, accountName: "Student Mastercard", balance: 50.83)
//        let investment1 = AccountSumary(accountType: .Investment, accountName: "Tax-Free Saver", balance: 2000.00)
//        let investment2 = AccountSumary(accountType: .Investment,accountName: "Growth Fund", balance: 15000.00)
//
//        accountsDataCell.append(savings)
//        accountsDataCell.append(chequing)
//        accountsDataCell.append(visa)
//        accountsDataCell.append(masterCard)
//        accountsDataCell.append(investment1)
//        accountsDataCell.append(investment2)
//    }
//}


extension AccountSummaryViewController {
    func SetTargets(){
    }

    @objc func refreshContent() {
        reset()
        setupSkeletons()
        tableView.reloadData()
        fetchData()
    }
    
    private func reset() {
        profile = nil
        accounts = []
        isLoaded = false
    }
    
    @objc func logoutTapped(sender: UIButton){
        NotificationCenter.default.post(name: .logout, object: nil)
    }
}





// MARK: - Networking
extension AccountSummaryViewController {
    private func fetchData() {
            let group = DispatchGroup()
            
            // Testing - random number selection
            let userId = String(Int.random(in: 1..<4))
            
            fetchProfile(group: group, userId: userId)
            fetchAccounts(group: group, userId: userId)
            
            group.notify(queue: .main) {
                self.reloadView()
            }
        }
        
        private func fetchProfile(group: DispatchGroup, userId: String) {
        group.enter()
            profileManager.fetchProfile(forUserId: userId) { result in
            switch result {
            case .success(let profile):
                self.profile = profile
            case .failure(let error):
                self.displayError(error)
            }
            group.leave()
        }
    }
        
    private func fetchAccounts(group: DispatchGroup, userId: String) {
        group.enter()
        profileManager.fetchAccounts(forUserId: userId) { result in
            switch result {
            case .success(let accounts):
                self.accounts = accounts
            case .failure(let error):
                self.displayError(error)
            }
            group.leave()
        }
    }
        
    private func reloadView() {
        self.tableView.refreshControl?.endRefreshing()
        
        guard let profile = self.profile else { return }
        
        self.isLoaded = true
        self.configureTableHeaderView(with: profile)
        self.configureTableCells(with: self.accounts)
        self.tableView.reloadData()
    }
    
    private func configureTableHeaderView(with profile: Profile) {
        let vm = DataAccountHeader(welcomeMessage: "Good morning,", name: profile.firstName, date: Date())
        configure(dataAccount: vm)
    }
    
    private func configureTableCells(with accounts: [Account]) {
        accountsDataCell = accounts.map {
            AccountSumary(accountType: $0.type,
                          accountName: $0.name,
                          balance: $0.amount)
        }
    }
    
    private func displayError(_ error: NetworkError) {
        let titleAndMessage = titleAndMessage(for: error)
        self.showErrorAlert(title: titleAndMessage.0, message: titleAndMessage.1)
    }

    private func titleAndMessage(for error: NetworkError) -> (String, String) {
        let title: String
        let message: String
        switch error {
        case .serverError:
            title = "Server Error"
            message = "We could not process your request. Please try again."
        case .decodingError:
            title = "Network Error"
            message = "Ensure you are connected to the internet. Please try again."
        }
        return (title, message)
    }
    
    private func showErrorAlert(title: String, message: String) {
//        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        errorAlert.title = title
        errorAlert.message = message
        
        present(errorAlert, animated: true, completion: nil)
    }
}

//MARK: Unit testing
extension AccountSummaryViewController {
    func titleAndMessageForTesting(for error: NetworkError) -> (String, String) {
        return titleAndMessage(for: error)
    }
    
    func forceFetchProfile() {
        fetchProfile(group: DispatchGroup(), userId: "1")
    }
    
    func forceFetchAccount() {
        fetchAccounts(group: DispatchGroup(), userId: "1")
    }
    
}
