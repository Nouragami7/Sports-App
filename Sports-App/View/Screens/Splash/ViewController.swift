//
//  ViewController.swift
//  Sports-App
//
//  Created by macOS on 29/05/2025.
//

import UIKit
import Alamofire
import Lottie

class ViewController: UIViewController {


    private var animationView: LottieAnimationView!
       private let appNameLabel: UILabel = {
           let label = UILabel()
           label.text = "Proleague"
           label.font = UIFont.boldSystemFont(ofSize: 30)
           label.textColor = .purple
           label.textAlignment = .center
           label.alpha = 0
           return label
       }()
           
       override func viewDidLoad() {
           super.viewDidLoad()
           view.backgroundColor = .white
           setupAnimation()
           setupLabel()
       }
       
       private func setupAnimation() {
           animationView = .init(name: "app-logo")
           animationView.frame = CGRect(x: 0, y: 0, width: 350, height: 350)
           animationView.center = CGPoint(x: view.center.x, y: view.center.y - 40)
           animationView.contentMode = .scaleAspectFit
           animationView.loopMode = .playOnce
           animationView.animationSpeed = 1.5

           view.addSubview(animationView)

           animationView.play { [weak self] finished in
               if finished {
                   UIView.animate(withDuration: 0.4) {
                       self?.appNameLabel.alpha = 1
                   }
                   DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                       self?.navigateToHome()
                   }
               }
           }
       }
       
       private func setupLabel() {
           view.addSubview(appNameLabel)
           appNameLabel.translatesAutoresizingMaskIntoConstraints = false
           
           NSLayoutConstraint.activate([
               appNameLabel.topAnchor.constraint(equalTo: animationView.bottomAnchor, constant: 12),
               appNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
           ])
       }

       func navigateToHome() {
           let hasSeenOnboarding = UserDefaults.standard.bool(forKey: "hasSeenOnboarding")

           let storyboardName = hasSeenOnboarding ? "Main" : "Onboarding"
           let viewControllerID = hasSeenOnboarding ? "MainNavigationController" : "OnboardingViewController"

           let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
           let destinationVC = storyboard.instantiateViewController(withIdentifier: viewControllerID)

           if let window = UIApplication.shared.windows.first {
               window.rootViewController = destinationVC
               window.makeKeyAndVisible()

               UIView.transition(with: window,
                                 duration: 0.3,
                                 options: .transitionCrossDissolve,
                                 animations: nil,
                                 completion: nil)
           }
       }
   }
