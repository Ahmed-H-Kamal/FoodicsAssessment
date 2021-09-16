//
//  NavigationHeaderViewModel.swift
//  Foodics
//
//  Created by Ahmed Hamdy on 16/09/2021.
//

import Foundation


class NavigationHeaderViewModel: NSObject, RowViewModel {

    func cellIdentifier() -> String {
        return NavigationHeaderViewCell.cellIdentifier()
    }
    

}
