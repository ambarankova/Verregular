//
//  TrainViewController.swift
//  Verrugular
//
//  Created by Анастасия Ахановская on 05.07.2024.
//

import UIKit
import SnapKit

final class TrainViewController: UIViewController {
    
    // MARK: - GUI Variables
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        
        view.showsVerticalScrollIndicator = false
        
        return view
    }()
    
    private lazy var contentView: UIView = UIView()
    
    private lazy var infinitiveLabel: UILabel = {
        let label = UILabel()
        
        label.font = .boldSystemFont(ofSize: 28)
        label.textColor = .black
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var pastSimpleLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        label.text = "Past Simple"
        
        return label
    }()
    
    private lazy var participalLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        label.text = "Past Participle"
        
        return label
    }()
    
    private lazy var scoreLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        label.text = "Score".localized + ": \(score)"
        
        return label
    }()
    
    private lazy var numberLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        label.text = "Verb".localized + ": \(count)"  + " from".localized + " \(dataSourse.count)"
        
        return label
    }()
    
    private lazy var pastSimpleTextField: UITextField = {
        let textField = UITextField()
        
        textField.borderStyle = .roundedRect
        textField.delegate = self
        
        return textField
    }()
    
    private lazy var participleTextField: UITextField = {
        let textField = UITextField()
        
        textField.borderStyle = .roundedRect
        textField.delegate = self
        
        return textField
    }()
    
    private lazy var checkButton: UIButton = {
        let button = UIButton()
        
        button.layer.cornerRadius = 10
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemGray5
        button.setTitle("Check".localized, for: .normal)
        button.addTarget(self, action: #selector(checkAction), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var skipButton: UIButton = {
        let button = UIButton()
        
        button.layer.cornerRadius = 10
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemGray5
        button.setTitle("Skip".localized, for: .normal)
        button.addTarget(self, action: #selector(skipAction), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Properties
    private let edgesInsets = 30
    private let dataSourse = IrregularVerbs.shared.selectedVerbs
    private var score = 0
    private var currentVerb: Verb? {
        guard dataSourse.count > count else {return nil}
        return dataSourse[count]
    }
    private var count = 0 {
        didSet{
            infinitiveLabel.text = currentVerb?.infinitive
            pastSimpleTextField.text = ""
            participleTextField.text = ""
        }
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Train verbs".localized
        
        setupUI()
        hideKeyboardWhenTappedAround()
        
        infinitiveLabel.text = dataSourse.first?.infinitive
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        registerForKeyboardNotification()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        unregisterForKeyboardNotification()
    }
    
    // MARK: - Private Methods
    @objc private func checkAction() {
        if checkAnswers() {
            
            if checkButton.titleLabel?.text == "Check".localized {
                score += 1
                scoreLabel.text = "Score".localized + ": \(score)"
            }
            
            if currentVerb?.infinitive == dataSourse.last?.infinitive {
                
                let alert = UIAlertController(title: "Training is over".localized, message: "Score".localized + ": \(score)", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK".localized, style: .default)
                alert.addAction(action)
                present(alert, animated: true)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.navigationController?.popViewController(animated: true)
                }
            } else {
                count += 1
                numberLabel.text = "Verb".localized + ": \(count)"  + " " + "from".localized + " \(dataSourse.count)"
                checkButton.backgroundColor = .systemGray5
                checkButton.setTitle("Check".localized, for: .normal)
            }
        } else {
            checkButton.backgroundColor = .systemRed
            checkButton.setTitle("Try again".localized, for: .normal)
        }
    }
    
    private func checkAnswers() -> Bool {
        pastSimpleTextField.text?.lowercased() == currentVerb?.pastSimple.lowercased() && participleTextField.text?.lowercased() == currentVerb?.participal.lowercased()
    }
    
    @objc private func skipAction() {
        
        let alert = UIAlertController(title: "Remember verb".localized, message: "\(currentVerb?.infinitive ?? "") - \(currentVerb?.pastSimple ?? "") - \(currentVerb?.participal ?? "")", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK".localized, style: .default)
        alert.addAction(action)
        present(alert, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.count += 1
        }
    }
        
        private func setupUI() {
            view.backgroundColor = .white
            
            view.addSubview(scrollView)
            scrollView.addSubview(contentView)
            contentView.addSubviews([
                infinitiveLabel,
                pastSimpleLabel,
                pastSimpleTextField,
                participalLabel,
                participleTextField,
                checkButton,
                scoreLabel,
                numberLabel,
                skipButton])
            
            setupConstrains()
        }
        
        private func setupConstrains() {
            scrollView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            
            contentView.snp.makeConstraints { make in
                make.size.edges.equalToSuperview()
            }
            
            infinitiveLabel.snp.makeConstraints { make in
                make.top.equalToSuperview().inset(200)
                make.trailing.leading.equalToSuperview().inset(edgesInsets)
            }
            
            pastSimpleLabel.snp.makeConstraints { make in
                make.top.equalTo(infinitiveLabel.snp.bottom).offset(60)
                make.trailing.leading.equalToSuperview().inset(edgesInsets)
            }
            
            pastSimpleTextField.snp.makeConstraints { make in
                make.top.equalTo(pastSimpleLabel.snp.bottom).offset(10)
                make.trailing.leading.equalToSuperview().inset(edgesInsets)
            }
            
            participalLabel.snp.makeConstraints { make in
                make.top.equalTo(pastSimpleTextField.snp.bottom).offset(20)
                make.trailing.leading.equalToSuperview().inset(edgesInsets)
            }
            
            participleTextField.snp.makeConstraints { make in
                make.top.equalTo(participalLabel.snp.bottom).offset(10)
                make.trailing.leading.equalToSuperview().inset(edgesInsets)
            }
            
            checkButton.snp.makeConstraints { make in
                make.top.equalTo(participleTextField.snp.bottom).offset(100)
                make.trailing.leading.equalToSuperview().inset(edgesInsets)
            }
            
            scoreLabel.snp.makeConstraints { make in
                make.top.equalToSuperview().inset(50)
                make.trailing.leading.equalToSuperview().inset(edgesInsets)
            }
            
            numberLabel.snp.makeConstraints { make in
                make.top.equalTo(scoreLabel).offset(20)
                make.trailing.leading.equalToSuperview().inset(edgesInsets)
            }
            
            skipButton.snp.makeConstraints { make in
                make.top.equalTo(checkButton.snp.bottom).offset(30)
                make.trailing.leading.equalToSuperview().inset(edgesInsets)
            }
        }
    }

// MARK: - UITextFieldDelegate
extension TrainViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if pastSimpleTextField.isFirstResponder {
            participleTextField.becomeFirstResponder()
        } else {
            scrollView.endEditing(true)
        }
        return true
    }
}

//MARK: - Keyboard events
private extension TrainViewController {
    func registerForKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unregisterForKeyboardNotification() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {return}
        
        scrollView.contentInset.bottom = frame.height + 50
    }
    
    @objc func keyboardWillHide() {
        scrollView.contentInset.bottom = .zero - 50
    }
    
    func hideKeyboardWhenTappedAround() {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        scrollView.addGestureRecognizer(recognizer)
    }
    
    @objc func hideKeyboard() {
        scrollView.endEditing(true)
    }
}
