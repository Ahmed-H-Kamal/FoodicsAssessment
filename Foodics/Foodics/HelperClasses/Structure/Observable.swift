//
//  Observable.swift
//  Foodics
//
//  Created by Ahmed Hamdy on 15/09/2021.
//

import Foundation
class Observable<T> {
    private var valueChanged: ((T) -> Void)?
    
    var value: T {
        didSet {
            DispatchQueue.main.async {
                self.valueChanged?(self.value)
            }
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    /// Add closure as an observer and trigger the closure imeediately if fireNow = true
    func addObserver(fireNow: Bool = true, _ onChange: ((T) -> Void)?) {
        valueChanged = onChange
        if fireNow {
            onChange?(value)
        }
    }
    
    func removeObserver() {
        valueChanged = nil
    }
}
