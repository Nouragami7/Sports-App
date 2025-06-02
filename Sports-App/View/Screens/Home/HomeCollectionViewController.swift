//
//  HomeCollectionViewController.swift
//  Sports-App
//
//  Created by Ayat on 29/05/2025.
//

import UIKit


class HomeCollectionViewController: UICollectionViewController , UICollectionViewDelegateFlowLayout{
    var sports: [Sport] = SportsData.sports
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Sports"
       // self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
   
        // Configure layout
          /*    if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                  layout.minimumLineSpacing = 16       // Vertical spacing between rows
                  layout.minimumInteritemSpacing = 8   // Horizontal spacing between columns
                  layout.scrollDirection = .vertical
                  layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
              }*/
     }

    @IBOutlet weak var titleOfScreen: UINavigationItem!
    class HomeCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
        override func viewDidLoad() {
            super.viewDidLoad()
            
            if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.minimumLineSpacing = 8
                
                layout.minimumInteritemSpacing = 4
                layout.scrollDirection = .vertical
                layout.sectionInset = UIEdgeInsets(top: 4, left: 4, bottom: 0, right: 8)
            }
        }
        
        func collectionView(_ collectionView: UICollectionView,
                           layout collectionViewLayout: UICollectionViewLayout,
                           sizeForItemAt indexPath: IndexPath) -> CGSize {
            
            let padding: CGFloat = 4
            let availableWidth = collectionView.bounds.width - (padding * 3)
            let widthPerItem = availableWidth / 2
            
            return CGSize(width: widthPerItem, height: widthPerItem * 1.4)
        }
    }

    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sports.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sportCell", for: indexPath)
        

               // Configure the cell appearance
               cell.layer.borderWidth = 1
               cell.layer.borderColor = UIColor.purple.cgColor
               cell.layer.cornerRadius = 24
               cell.layer.shadowColor = UIColor.black.cgColor
               cell.layer.shadowOpacity = 0.2
               cell.layer.shadowOffset = CGSize(width: 0, height: 3)
               cell.layer.shadowRadius = 5
               cell.layer.masksToBounds = false
               
               // Configure image view
               if let imageView = cell.viewWithTag(1) as? UIImageView {
                   imageView.image = UIImage(named: sports[indexPath.item].imageName)
                   imageView.layer.shadowColor = UIColor.black.cgColor
                   imageView.layer.shadowOpacity = 0.2
                   imageView.layer.shadowOffset = CGSize(width: 0, height: 3)
                   imageView.layer.shadowRadius = 5
                   imageView.layer.masksToBounds = false
               }
               
               // Configure title label
               if let titleLabel = cell.viewWithTag(2) as? UILabel {
                   titleLabel.text = sports[indexPath.item].name
                   titleLabel.backgroundColor = UIColor.purple
                   titleLabel.textColor = .white
                   titleLabel.layer.cornerRadius = 12
                   titleLabel.clipsToBounds = true
               }
               

        
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.purple.cgColor
        cell.layer.cornerRadius = 24

        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.2
        cell.layer.shadowOffset = CGSize(width: 0, height: 3)
        cell.layer.shadowRadius = 5
        cell.layer.masksToBounds = false



        if let imageView = cell.viewWithTag(1) as? UIImageView {
            imageView.image = UIImage(named: sports[indexPath.item].imageName)
            imageView.layer.shadowColor = UIColor.black.cgColor
            imageView.layer.shadowOpacity = 0.2
            imageView.layer.shadowOffset = CGSize(width: 0, height: 3)
            imageView.layer.shadowRadius = 5
            imageView.layer.masksToBounds = false

        }


        if let titleLabel = cell.viewWithTag(2) as? UILabel {
            titleLabel.text = sports[indexPath.item].name
            titleLabel.backgroundColor = UIColor.purple
            titleLabel.textColor = .white
            titleLabel.layer.cornerRadius = 12
            titleLabel.clipsToBounds = true
        }

        return cell
    }

    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedSport = sports[indexPath.row].name
        
        switch(selectedSport) {
        case "Football", "Basketball", "Tennis", "Cricket":
            let leaguesVC = LeaguesTableViewController(nibName: "LeaguesTableViewController", bundle: nil)
            leaguesVC.sport = selectedSport
            self.navigationController?.pushViewController(leaguesVC, animated: true)
      
        default:
            let leaguesVC = LeaguesTableViewController(nibName: "LeaguesTableViewController", bundle: nil)
            self.navigationController?.pushViewController(leaguesVC, animated: true)
        }
    }


    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        let cellSize = self.collectionView(self.collectionView, layout: collectionView.collectionViewLayout, sizeForItemAt: IndexPath(item: 0, section: 0))
        let totalCellHeight = cellSize.height * 2
        let totalSpacing: CGFloat = 20
        let totalContentHeight = totalCellHeight + totalSpacing
        let verticalInset = max((collectionView.frame.height - totalContentHeight) / 2, 0)

        collectionView.contentInset = UIEdgeInsets(top: verticalInset, left: 10, bottom: 0, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemsPerRow: CGFloat = 2
        let padding: CGFloat = 10
        let interItemSpacing: CGFloat = 5
        let totalSpacing = (itemsPerRow - 1) * interItemSpacing + 2 * padding

        let availableWidth = collectionView.bounds.width - totalSpacing
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem)

    }



}
