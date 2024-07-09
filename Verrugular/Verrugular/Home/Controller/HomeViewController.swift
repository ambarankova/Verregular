//
//  ViewController.swift
//  Verrugular
//
//  Created by Анастасия Ахановская on 03.07.2024.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - GUI Variables
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Verregular".uppercased()
        label.font = .boldSystemFont(ofSize: 28)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    /// Создадим метод для создания кнопок, что бы сократить количество кода
    private lazy var firstButton = createButton(title: "Select verbs", target: #selector(goToSelectViewController))
    private lazy var secondButton = createButton(title: "Train verbs", target: #selector(goToTrainViewController))

    // MARK: - Properties
    private let cornerRadius: CGFloat = 20
    private let buttonHighе: CGFloat = 80
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: - Private methods
    @objc private func goToSelectViewController() {
        navigationController?.pushViewController(SelectVerbsViewController(), animated: true)
    }
    
    @objc private func goToTrainViewController() {
        navigationController?.pushViewController(TrainViewController(), animated: true)
    }
    
    private func configureUI() {
        /// Пример (плюс у тебя в проекте есть расширение addSubviews):
        [titleLabel, firstButton, secondButton].forEach {view.addSubview($0)}
        view.backgroundColor = .white
        setupConstrains()
    }
    
    private func setupConstrains() {
        firstButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        firstButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        firstButton.heightAnchor.constraint(equalToConstant: buttonHighе).isActive = true
        firstButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80).isActive = true
        
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: firstButton.topAnchor, constant: -80).isActive = true
        
        secondButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        secondButton.topAnchor.constraint(equalTo: firstButton.bottomAnchor, constant: 40).isActive = true
        secondButton.heightAnchor.constraint(equalToConstant: buttonHighе).isActive = true
        secondButton.widthAnchor.constraint(equalTo: firstButton.widthAnchor).isActive = true
    }
    
    private func createButton(title: String, target: Selector)-> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemGray5
        button.layer.cornerRadius = cornerRadius
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: target, for: .touchUpInside)
        return button
    }
}
