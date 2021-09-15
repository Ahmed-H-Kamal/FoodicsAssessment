//
//  RowViewModel.swift
//  Foodics
//
//  Created by Ahmed Hamdy on 15/09/2021.
//


import Foundation

public protocol RowViewModel {
    func cellIdentifier() -> String
}

extension RowViewModel {
    func cellIdentifier() -> String{
        return ""
    }
}

public protocol ViewModelPressible {
    func cellPressed()
}

