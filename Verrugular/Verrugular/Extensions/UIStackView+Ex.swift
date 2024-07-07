//
//  UIStackView+Ex.swift
//  Verrugular
//
//  Created by Анастасия Ахановская on 07.07.2024.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach { view in
            addArrangedSubview(view)
        }
    }
}
