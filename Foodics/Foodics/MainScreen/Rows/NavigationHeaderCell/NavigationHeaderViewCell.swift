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
        
        if self.viewModel?.selectedPageIndex == 1{
            self.nextButton.isEnabled = true
            self.backButton.isEnabled = false
        }else{
            self.nextButton.isEnabled = false
            self.backButton.isEnabled = true
        }
    }

    @IBAction func nextButtonAction(_ sender: Any) {
        self.viewModel?.didClickNextButton?()
        if self.viewModel?.selectedPageIndex == 2{
            self.nextButton.isEnabled = false
            self.backButton.isEnabled = true
        }else{
            self.nextButton.isEnabled = true
            self.backButton.isEnabled = false
        }
    }
    
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.viewModel?.didClickBackButton?()
        if self.viewModel?.selectedPageIndex == 1{
            self.nextButton.isEnabled = true
            self.backButton.isEnabled = false
        }else{
            self.nextButton.isEnabled = false
            self.backButton.isEnabled = true
        }
    }
    
}

