//
//  CategoryItemViewCell.swift
//  Foodics
//
//  Created by Ahmed Hamdy on 16/09/2021.
//

import Foundation
import UIKit
import SDWebImage

class CategoryItemViewCell: UICollectionViewCell, CellConfigurable {
    
    var viewModel: CategoryItemViewModel?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var viewBottom: UIView!

    // MARK:- configuration
    func setup(viewModel: RowViewModel) {
        if let viewModel = viewModel as? CategoryItemViewModel{
            if let category = viewModel.category{
                self.titleLabel.text = category.name
                
                if let image = category.image{
                    self.categoryImage.sd_setImage(with: URL(string: image))
                }
            }
        }
    }

    override var isSelected: Bool {
        didSet {
            self.contentView.backgroundColor = isSelected ? UIColor.init(hexString: "DCDCDC") : UIColor.white
        }
    }
    

}

