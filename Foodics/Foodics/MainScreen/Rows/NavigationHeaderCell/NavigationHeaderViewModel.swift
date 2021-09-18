//
//  NavigationHeaderViewModel.swift
//  Foodics
//
//  Created by Ahmed Hamdy on 16/09/2021.
//

import Foundation


class NavigationHeaderViewModel: NSObject, RowViewModel {

    var didClickNextButton : (() -> Void)?
    var didClickBackButton : (() -> Void)?
    var selectedPageIndex = 1
    var links : Links?

    func cellIdentifier() -> String {
        return NavigationHeaderViewCell.cellIdentifier()
    }
    init(with selectedPageIndex : Int) {
        self.selectedPageIndex = selectedPageIndex
    }
    init(with links : Links?) {
        self.links = links
    }
}
