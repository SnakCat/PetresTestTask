//
//  Extensions.swift
//  PetresTestTask
//
//  Created by DimaTru on 27.11.2025.
//

import UIKit

//MARK: - расширение для добавления на View
extension UIView {
    func addSubviews(_ view: UIView...) {
        view.forEach(addSubview)
    }
}
