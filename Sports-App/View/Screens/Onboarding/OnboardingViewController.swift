//
//  OnboardingViewController.swift
//  Sports-App
//
//  Created by macOS on 08/06/2025.
//

import UIKit

class OnboardingViewController: UIPageViewController,UIPageViewControllerDataSource {

    lazy var vcArray: [UIViewController] = {
          let storyBoard = UIStoryboard(name: "Onboarding", bundle: nil)
          
          let one = storyBoard.instantiateViewController(withIdentifier: "one")
          let two = storyBoard.instantiateViewController(withIdentifier: "two")
          let three = storyBoard.instantiateViewController(withIdentifier: "three")
          
          return [one,two,three]
      }()
      
      var currentPage = 0

      override func viewDidLoad() {
          super.viewDidLoad()
          self.dataSource = self
          if let vc = vcArray.first{
              self.setViewControllers([vc], direction: .forward, animated: true)
          }
          for view in self.view.subviews {
                  if view is UIScrollView {
                      view.frame = UIScreen.main.bounds
                  }
              }
      }
      

      func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
          guard let index = vcArray.lastIndex(of: viewController) else { return nil }
          let previousIndex = index - 1
          guard previousIndex >= 0 else {return nil}
          guard previousIndex < vcArray.count else {return nil}
          currentPage = index - 1
          return vcArray[previousIndex]
      }
      
      func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
          guard let index = vcArray.lastIndex(of: viewController) else { return nil }
          let previousIndex = index + 1
          guard previousIndex >= 0 else {return nil}
          guard previousIndex < vcArray.count else {return nil}
          currentPage = index + 1
          return vcArray[previousIndex]
      }
      
      func presentationIndex(for pageViewController: UIPageViewController) -> Int {
          return currentPage
      }
      
      func presentationCount(for pageViewController: UIPageViewController) -> Int {
          return vcArray.count
      }
    
   
}
