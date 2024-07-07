//
//  UIView+Ex.swift
//  Verrugular
//
//  Created by Анастасия Ахановская on 07.07.2024.
//

import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach { view in
            addSubview(view)
        }
    }
}
