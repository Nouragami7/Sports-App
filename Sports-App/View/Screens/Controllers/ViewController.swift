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
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .white
            setupAnimation()
        }
        
        private func setupAnimation() {
            animationView = .init(name: "logo")
            animationView.frame = view.bounds
            animationView.contentMode = .scaleAspectFit
            animationView.center = view.center
            animationView.loopMode = .playOnce
            animationView.animationSpeed = 1.0
            
            view.addSubview(animationView)
            
            animationView.play { [weak self] finished in
                if finished {
                    self?.navigateToHome()
                }
            }
        }
        
        func navigateToHome() {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let teamDetailsVC = storyboard.instantiateViewController(withIdentifier: "homeScreen") as? HomeCollectionViewController {
                self.navigationController?.pushViewController(teamDetailsVC, animated: true)
            }
    }

}

