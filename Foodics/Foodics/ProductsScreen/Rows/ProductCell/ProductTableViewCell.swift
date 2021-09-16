//
//  ProductTableViewCell.swift
//  Foodics
//
//  Created by Ahmed Hamdy on 16/09/2021.
//

import Foundation
import UIKit
import SDWebImage

class ProductTableViewCell: UITableViewCell, CellConfigurable{
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var priceIcon: UIImageView!
    @IBOutlet weak var activeLabel: UILabel!
    @IBOutlet weak var activeIcon: UIImageView!

    var viewModel: ProductTableViewModel?
    
    func setup(viewModel: RowViewModel) {
        guard let viewModel = viewModel as? ProductTableViewModel else { return }
        self.viewModel = viewModel
        self.titleLabel.text = viewModel.product.name
        
        if let subtitle = viewModel.product.createdAt{
            self.subTitleLabel.text = "Created at \(subtitle)"
        }
        
        if(viewModel.product.price ?? 0 > 0){
            self.priceLabel.text = "This item will cost " + String(viewModel.product.price ?? 0) + " SR"
        }else{
            self.priceLabel.isHidden = true
            self.priceIcon.isHidden = true
        }
        if let cover = viewModel.product.image{
            self.productImage.sd_setImage(with: URL(string: cover))
        }
        
        if viewModel.product.isActive ?? false{
            self.activeLabel.text = "Active"
            self.activeIcon.tintColor = UIColor.systemGreen
        }else{
            self.activeLabel.text = "In-Active"
            self.activeIcon.tintColor = UIColor.red
        }

        
    }
    
}
