//
//  String+Ex.swift
//  Verrugular
//
//  Created by Анастасия Ахановская on 03.07.2024.
//

import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}
