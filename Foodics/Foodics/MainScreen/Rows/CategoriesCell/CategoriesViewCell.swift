//
//  CategoriesViewCell.swift
//  Foodics
//
//  Created by Ahmed Hamdy on 16/09/2021.
//

import Foundation
import UIKit
class CategoriesViewCell: UITableViewCell, CellConfigurable{
    
    var viewModel: CategoriesListViewModel?
        
    @IBOutlet weak var collectionView: UICollectionView!
    
    func setup(viewModel: RowViewModel) {
        guard let viewModel = viewModel as? CategoriesListViewModel else { return }
        self.viewModel = viewModel
        
        collectionView.register(UINib(nibName: "CategoryItemViewCell", bundle: nil), forCellWithReuseIdentifier: CategoryItemViewCell.cellIdentifier())
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
        setCollectionViewFlowLayout()

    }
    
}


extension CategoriesViewCell : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return self.viewModel?.categoriesList.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryItemViewCell.cellIdentifier(), for: indexPath) as! CategoryItemViewCell
                
        let rowViewModel = CategoryItemViewModel(category: self.viewModel?.categoriesList[indexPath.row])
                
        cell.setup(viewModel: rowViewModel)

        return cell
    
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let id = self.viewModel?.categoriesList[indexPath.row].id{
            self.viewModel?.didSelectCategory?(id)
        }
    }

    func setCollectionViewFlowLayout() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: self.frame.size.width, height: 160)
        layout.scrollDirection = .vertical
        self.collectionView.collectionViewLayout = layout
    }
    
}
