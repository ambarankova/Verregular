//
//  IrregularVerbs.swift
//  Verbs
//
//  Created by Анастасия Ахановская on 03.07.2024.
//

import Foundation

class IrregularVerbs {
    
    // Singletone
    static var shared = IrregularVerbs()
    private init() {
        configureVerbs()
        selectedVerbs.append(contentsOf: verbs)
    }
    
    // MARK: - Properties
    private(set) var verbs: [Verb] = []
    var selectedVerbs: [Verb] = []
    
    // MARK: - Methods
    private func configureVerbs() {
        verbs = [
        Verb(infinitive: "blow", pastSimple: "blew", participal: "blown"),
        Verb(infinitive: "draw", pastSimple: "drew", participal: "drawn"),
        Verb(infinitive: "eat", pastSimple: "ate", participal: "eaten"),
        Verb(infinitive: "fall", pastSimple: "fell", participal: "fallen"),
        Verb(infinitive: "beat", pastSimple: "beat", participal: "beaten"),
        Verb(infinitive: "become", pastSimple: "became", participal: "become"),
        Verb(infinitive: "break", pastSimple: "broke", participal: "broken"),
        Verb(infinitive: "bring", pastSimple: "brought", participal: "brought"),
        Verb(infinitive: "cut", pastSimple: "cut", participal: "cut"),
        Verb(infinitive: "hit", pastSimple: "hit", participal: "hit"),
        Verb(infinitive: "bet", pastSimple: "bet", participal: "bet"),
        Verb(infinitive: "set", pastSimple: "set", participal: "set"),
        Verb(infinitive: "cost", pastSimple: "cost", participal: "cost"),
        Verb(infinitive: "quit", pastSimple: "quit", participal: "quit")
        ]
    }
}
