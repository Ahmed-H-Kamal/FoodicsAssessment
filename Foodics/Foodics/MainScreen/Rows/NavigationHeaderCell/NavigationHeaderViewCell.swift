//
//  TopHeaderViewCell.swift
//  Foodics
//
//  Created by Ahmed Hamdy on 16/09/2021.
//

import Foundation
import UIKit

class NavigationHeaderViewCell: UITableViewCell, CellConfigurable {
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    var viewModel: NavigationHeaderViewModel?
    
    // MARK:- configuration
    func setup(viewModel: RowViewModel) {
        guard let viewModel = viewModel as? NavigationHeaderViewModel else { return }
        self.viewModel = viewModel
        
        self.backButton.isEnabled = (self.viewModel?.links?.prev != nil)
        self.nextButton.isEnabled = (self.viewModel?.links?.next != nil)

    }

    @IBAction func nextButtonAction(_ sender: Any) {
        self.viewModel?.didClickNextButton?()
    }
    
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.viewModel?.didClickBackButton?()
    }
    
}

