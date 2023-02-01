//
//  AppDelegate.swift
//  Bankey Sam
//
//  Created by Samuel Fuentes Navarrete on 30/01/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var hasOnboarding = false
    
    let loginViewController = LoginViewController()
    let onboardingViewController = OnboardingContainerViewController()
    let dummyViewController = DummyViewController()

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        
//        window?.rootViewController = loginViewController
        loginViewController.delgateView = self
        
        //window?.rootViewController = onboardingViewController
        onboardingViewController.delegateView = self
        
        dummyViewController.delegateView = self
        
        window?.rootViewController = loginViewController
        //window?.rootViewController = OnboardingContainerViewController()
        //window?.rootViewController = OnboardingViewController(heroImageName: <#T##String#>, titleText: <#T##String#>

        return true
    }

}

extension AppDelegate{
    func setRootViewController(_ view: UIViewController, animated: Bool = true){
        guard animated, let window = self.window else {
            self.window?.rootViewController = view
            self.window?.makeKeyAndVisible()
            return
        }
        
        window.rootViewController = view
        window.makeKeyAndVisible()
        UIView.transition(with: window, duration: 1.0, options: .transitionCrossDissolve, animations: nil, completion: nil)
    }
}



extension AppDelegate: LoginView{
    func didLogin() {
        //setRootViewController(onboardingViewController)
        if hasOnboarding{
            setRootViewController(dummyViewController)
        } else {
            setRootViewController(onboardingViewController)
        }
    }
    
    
    
    func didLogout() {
        setRootViewController(loginViewController)
    }
    
    
}



extension AppDelegate: OnboardingContainerView{
    func didFinishOnboarding() {
        hasOnboarding = true
        setRootViewController(dummyViewController)
    }
}



