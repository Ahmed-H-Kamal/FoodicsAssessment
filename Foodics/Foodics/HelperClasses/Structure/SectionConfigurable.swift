//
//  SectionConfigurable.swift
//  Foodics
//
//  Created by Ahmed Hamdy on 15/09/2021.
//


import Foundation
import UIKit

protocol SectionConfigurable {
    func setup(viewModel: SectionViewModel)
    static func createView(viewModel : SectionViewModel) -> UIView?
}
