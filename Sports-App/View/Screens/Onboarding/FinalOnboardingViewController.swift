//
//  FinalOnboardingViewController.swift
//  Sports-App
//
//  Created by macOS on 08/06/2025.
//

import UIKit

class FinalOnboardingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func getStartedTapped(_ sender: UIButton) {
            UserDefaults.standard.set(true, forKey: "hasSeenOnboarding")
            UserDefaults.standard.synchronize()

            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let navController = storyboard.instantiateViewController(withIdentifier: "MainNavigationController")

            if let window = UIApplication.shared.windows.first {
                window.rootViewController = navController
                window.makeKeyAndVisible()

                UIView.transition(with: window,
                                  duration: 0.3,
                                  options: .transitionCrossDissolve,
                                  animations: nil,
                                  completion: nil)
            }
        }
    

}
