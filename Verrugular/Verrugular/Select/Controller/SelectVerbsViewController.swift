//
//  SelectVerbsViewController.swift
//  Verrugular
//
//  Created by Анастасия Ахановская on 05.07.2024.
//

import UIKit
import SnapKit

final class SelectVerbsViewController: UITableViewController {
    // MARK: - Properties
    private var dataSourse = IrregularVerbs.shared
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Select verbs".localized
        view.backgroundColor = .white
        tableView.register(SelectVerbTableViewCell.self, forCellReuseIdentifier: "SelectVerbTableViewCell")
        
    }
    
    //MARK: - Private Methods
    private func isSelected(verb: Verb) -> Bool {
        dataSourse.selectedVerbs.contains(where: { $0.infinitive == verb.infinitive })
    }
}

// MARK: - UITableViewDataSourse
extension SelectVerbsViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSourse.verbs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SelectVerbTableViewCell", for: indexPath) as? SelectVerbTableViewCell else { return UITableViewCell() }
        let verb = dataSourse.verbs[indexPath.row]
        cell.configure(with: verb, isSelected: isSelected(verb: verb))
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SelectVerbsViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let verb = dataSourse.verbs[indexPath.row]
        if isSelected(verb: verb) {
            dataSourse.selectedVerbs.removeAll(where: { $0.infinitive == verb.infinitive })
        } else {
            dataSourse.selectedVerbs.append(verb)
        }
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
