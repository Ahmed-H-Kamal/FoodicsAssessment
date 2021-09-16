//
//  PopupView.swift
//  Foodics
//
//  Created by Ahmed Hamdy on 16/09/2021.
//

import Foundation
import UIKit
class PopupView: UIView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!

    static func createViewWithMode(viewModel: PopupViewModel) -> PopupView? {
        let view = Bundle.main.loadNibNamed("PopupView", owner: self, options: nil)?.first as? PopupView
        view?.initView(viewModel: viewModel)
        return view;
    }
    
    func initView(viewModel: PopupViewModel) {
        self.titleLabel.text = viewModel.product?.name
        if let price = viewModel.product?.price{
            self.priceLabel.text = String(price) + " SR"
        }
        if let img = viewModel.product?.image{
            self.productImage.sd_setImage(with: URL(string: img))
        }
    }
    
    @IBAction func closeButtonAction(_ sender: Any) {
        self.removeFromSuperview()
    }
    
}
