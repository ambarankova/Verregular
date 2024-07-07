//
//  Verb.swift
//  Verbs
//
//  Created by Анастасия Ахановская on 03.07.2024.
//

import Foundation

struct Verb {
    let infinitive: String
    let pastSimple: String
    let participal: String
    var translation: String {
        NSLocalizedString(self.infinitive, comment: "")
    }
}
