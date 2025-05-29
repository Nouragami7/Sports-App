//
//  ViewController.swift
//  Sports-App
//
//  Created by macOS on 29/05/2025.
//

import UIKit
import Alamofire

class ViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()        
    }


    @IBAction func navigation(_ sender: Any) {
        let leaguesVC = LeaguesTableViewController(nibName: "LeaguesTableViewController", bundle: nil)
            self.navigationController?.pushViewController(leaguesVC, animated: true)
    }
}

