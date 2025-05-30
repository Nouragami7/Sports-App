//
//  LeagueDetailsCollectionViewController.swift
//  Sports-App
//
//  Created by Ayat on 30/05/2025.
//

import UIKit

private let reuseIdentifier = "Cell"

class LeagueDetailsCollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "UpCommingEventsCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "upcommingCell")
        
        
        let layout = UICollectionViewCompositionalLayout {sectionIndex,enviroment in
                switch sectionIndex {
                case 0 :
                    return self.upCommingEventsSection()
                case 1 :
                    return self.upCommingEventsSection()
                default:
                    return self.upCommingEventsSection()
                }
            }
            collectionView.setCollectionViewLayout(layout, animated: true)
            
            // Register cell classes
            self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
            
    //    self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)


    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section{
              case 0 :
                  return 8
              case 1 :
                  return 10
              default:
                  return 12
              }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        switch indexPath.section {
               case 0:
                   let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "upcommingCell", for: indexPath)
                   return cell
               case 1:
                   let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teamCell", for: indexPath)
            return cell
               default:
                   let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "matchCell", for: indexPath)
            return cell
               }
 
    }

    func upCommingEventsSection()-> NSCollectionLayoutSection {
           let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1)
                                                 , heightDimension: .fractionalHeight(1))
           let item = NSCollectionLayoutItem(layoutSize: itemSize)
           
           let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7)
                                                  , heightDimension: .absolute(225))
           let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize
                                                          , subitems: [item])
           group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0
                                                         , bottom: 0, trailing: 15)
           
           
           let section = NSCollectionLayoutSection(group: group)
           section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15
                                                           , bottom: 10, trailing: 0)
           section.orthogonalScrollingBehavior = .continuous
           section.visibleItemsInvalidationHandler = { (items, offset, environment) in
                items.forEach { item in
                let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
                let minScale: CGFloat = 0.8
                let maxScale: CGFloat = 1.0
                let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
                item.transform = CGAffineTransform(scaleX: scale, y: scale)
                }
           }
           return section
       }
       
    
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
