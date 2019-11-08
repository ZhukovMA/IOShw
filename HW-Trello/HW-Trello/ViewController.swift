//
//  CollectionViewCell.swift
//  HW-Trello
//
//  Created by Максим Жуков on 05/11/2019.
//  Copyright © 2019 Максим Жуков. All rights reserved.
//

import UIKit
class ViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    
    var models = [
        Model(title: "Todo", items: []),
        Model(title: "In Progress", items: []),
        Model(title: "InReview", items: []),
        Model(title: "Done", items: [])
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(ModelCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ModelCollectionViewCell
        cell.setup(with: models[indexPath.item])
        return cell
    }
    

    
}



