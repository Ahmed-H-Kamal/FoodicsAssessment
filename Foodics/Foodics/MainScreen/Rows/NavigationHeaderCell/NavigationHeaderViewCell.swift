//
//  TopHeaderViewCell.swift
//  Foodics
//
//  Created by Ahmed Hamdy on 16/09/2021.
//

import Foundation
import UIKit

class NavigationHeaderViewCell: UITableViewCell, CellConfigurable {
    
    var viewModel: NavigationHeaderViewModel?
    
    // MARK:- configuration
    func setup(viewModel: RowViewModel) {
        guard let viewModel = viewModel as? NavigationHeaderViewModel else { return }
        self.viewModel = viewModel
    }

    @IBAction func nextButtonAction(_ sender: Any) {
        self.viewModel?.didClickNextButton?()
    }
    
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.viewModel?.didClickBackButton?()
    }
    
}

