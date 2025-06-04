//
//  HomeCollectionViewController.swift
//  Sports-App
//
//  Created by Ayat on 29/05/2025.
//

import UIKit


class HomeCollectionViewController: UICollectionViewController , UICollectionViewDelegateFlowLayout{
    var sports: [Sport] = SportsData.sports
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { _ in
            self.collectionView.collectionViewLayout.invalidateLayout()
        })
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Sports"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
            let width = UIScreen.main.bounds.width * 0.03
           layout.sectionInset = UIEdgeInsets(top: 0, left: width, bottom: 16, right: width)
        }
        
        collectionView.contentInset = .zero
    }
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sports.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sportCell", for: indexPath) as? SportCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let sport = sports[indexPath.item]
        cell.configure(with: sport)
        
        return cell
    }
    
    // MARK: Item Size
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = UIScreen.main.bounds.width * 0.45
        let height = width * 1.3
        
        return CGSize(width: width, height: height)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedSport = sports[indexPath.row].name
        let leaguesVC = LeaguesTableViewController(nibName: "LeaguesTableViewController", bundle: nil)
        leaguesVC.sport = selectedSport
        self.navigationController?.pushViewController(leaguesVC, animated: true)
    }
}
