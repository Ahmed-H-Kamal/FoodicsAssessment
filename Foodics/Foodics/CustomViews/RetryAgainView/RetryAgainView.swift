//
//  RetryAgainView.swift
//  Foodics
//
//  Created by Ahmed Hamdy on 17/09/2021.
//

import Foundation
import UIKit
class RetryAgainView: UIView {
    var viewModel : RetryAgainViewModel?
    
    static func createViewWithMode(viewModel: RetryAgainViewModel) -> RetryAgainView? {
        let view = Bundle.main.loadNibNamed("RetryAgainView", owner: self, options: nil)?.first as? RetryAgainView
        view?.viewModel = viewModel
        return view;
    }
    
    
    @IBAction func retryButtonAction(_ sender: Any) {
        self.viewModel?.retryButtonClick?()
        self.removeFromSuperview()
    }
    
}
