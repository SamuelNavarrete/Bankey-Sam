//
//  AccountSummaryViewControllerTests.swift
//  BankeySamUnitTests
//
//  Created by Samuel Fuentes Navarrete on 07/02/23.
//

import Foundation
import XCTest

@testable import Bankey_Sam

class AccountSummaryViewControllerTests: XCTestCase {
    var vc: AccountSummaryViewController!
    var mockManager: MockProfileManager! //

    class MockProfileManager: ProfileManageable {
        
        var profile: Profile?
        var account: Account?
        var error: NetworkError?
        var fecha = Date()
        
        func fetchAccounts(forUserId userId: String, completion: @escaping (Result<[Account], NetworkError>) -> Void) {
            if error != nil {
                completion(.failure(error!))
                return
            }
            account = Account(id: "1", type: .Banking, name: "Basic Savings", amount: 929466.23, createdDateTime: fecha)
            completion(.success([account!]))
        }
        
        func fetchProfile(forUserId userId: String, completion: @escaping (Result<Profile, NetworkError>) -> Void) {
            if error != nil {
                completion(.failure(error!))
                return
            }
            profile = Profile(id: "1", firstName: "FirstName", lastName: "LastName")
            completion(.success(profile!))
        }
    }
       
    
    override func setUp() {
        super.setUp()
        vc = AccountSummaryViewController()
        // vc.loadViewIfNeeded()
        
        mockManager = MockProfileManager()
        vc.profileManager = mockManager
    }
    
    func testTitleAndMessageForServerError() throws {
        let titleAndMessage = vc.titleAndMessageForTesting(for: .serverError)
        XCTAssertEqual("Server Error", titleAndMessage.0)
        XCTAssertEqual("We could not process your request. Please try again.", titleAndMessage.1)
    }
    
    func testTitleAndMessageForNetworkError() throws {
        let titleAndMessage = vc.titleAndMessageForTesting(for: .decodingError)
        XCTAssertEqual("Network Error", titleAndMessage.0)
        XCTAssertEqual("Ensure you are connected to the internet. Please try again.", titleAndMessage.1)
    }
    
    func testAlertForServerError() throws {
        mockManager.error = NetworkError.serverError
        vc.forceFetchProfile()
        
        XCTAssertEqual("Server Error", vc.errorAlert.title)
        XCTAssertEqual("We could not process your request. Please try again.", vc.errorAlert.message)
        
        XCTAssertTrue(vc.errorAlert.title!.contains("Server"))
        XCTAssertTrue(vc.errorAlert.message!.contains("process your request"))

    }
    
    
    func testAlertForDecodingError() throws {
        mockManager.error = NetworkError.decodingError
        vc.forceFetchProfile()
        
        XCTAssertEqual("Network Error", vc.errorAlert.title)
        XCTAssertEqual("Ensure you are connected to the internet. Please try again.", vc.errorAlert.message)
        
        // Less coupling
        XCTAssertTrue(vc.errorAlert.title!.contains("Network"))
        XCTAssertTrue(vc.errorAlert.message!.contains("Ensure you are connected"))
    }
}
