//
//  SelectVerbTableViewCell.swift
//  Verrugular
//
//  Created by Анастасия Ахановская on 07.07.2024.
//

import UIKit
import SnapKit

final class SelectVerbTableViewCell: UITableViewCell {
    
    /// Создадим статик свойство что бы вызывать его и не допустить ошибку в написании класса ячейки при ее использовании/регистрации
    static let reuseID = UUID().uuidString
    
    enum State {
        case select, unselect
        
        var image: UIImage {
            switch self {
            case .select:
                return UIImage.checkmark
            case .unselect:
                return UIImage(systemName: "circlebadge") ?? UIImage.add
            }
        }
    }
    
    // MARK: - GUI Variables
    private lazy var checkboxImageView: UIImageView = {
        let view = UIImageView()
        
        view.image = State.unselect.image
        view.contentMode = .center
        
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.alignment = .center
        view.spacing = 5
        
        return view
    }()
    
    private lazy var infinitiveView: UIView = UIView()
    private lazy var infinitiveLbel = createLabel(font: .boldSystemFont(ofSize: 16))
    private lazy var translationLbel = createLabel(font: .systemFont(ofSize: 12), color: .gray)
    private lazy var pastLbel = createLabel(font: .systemFont(ofSize: 16), aligment: .center)
    private lazy var participalLbel = createLabel(font: .systemFont(ofSize: 16), aligment: .center)
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    func configure(with verb: Verb, isSelected: Bool) {
        infinitiveLbel.text = verb.infinitive
        translationLbel.text = verb.translation
        pastLbel.text = verb.pastSimple
        participalLbel.text = verb.participal
        
        checkboxImageView.image = isSelected ? State.select.image : State.unselect.image
    }
    
    // MARK: - Private Methods
    func setupUI() {
        selectionStyle = .none
        infinitiveView.addSubviews([infinitiveLbel, translationLbel])
        stackView.addArrangedSubviews([infinitiveView, pastLbel, participalLbel])
        addSubviews([checkboxImageView, stackView])
        
        setupConstraints()
    }
    
    func setupConstraints() {
        /// Пример:
        checkboxImageView.snp.makeConstraints {
            $0.width.height.equalTo(20)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
        }
        
        infinitiveLbel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        translationLbel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(infinitiveLbel.snp.bottom).offset(0)
        }
        
        infinitiveView.snp.makeConstraints { make in
            make.height.equalTo(69)
        }
        
        stackView.snp.makeConstraints { make in
            make.leading.equalTo(checkboxImageView.snp.trailing).offset(5)
            make.top.right.bottom.equalToSuperview()
        }
    }
    
    /// Немного сократим код, создав метод для создания и конфигурирвоания лейблов
    private func createLabel(font: UIFont,
                             aligment: NSTextAlignment? = nil,
                             color: UIColor? = nil) -> UILabel {
        let label = UILabel()
        label.font = font
        label.textColor = color
        label.textAlignment = aligment ?? .left
        return label
    }
}
