//
//  ProgrammingLanguageCell.swift
//  UITableHomeWork
//
//  Created by Артём Сноегин on 13.08.2025.
//
import UIKit

class ProgrammingLanguageCell: UITableViewCell {
    
    private let iconView = UIImageView()
    private let nameLabel = UILabel()
    private let useCaseLabel = UILabel()
    private let likeButton = UIButton()
    
    private let buttonImageConfig = UIImage.SymbolConfiguration(scale: .large)
    private var isFavorite: Bool = false

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(_ progLang: ProgrammingLanguage) {
        iconView.image = progLang.icon
        nameLabel.text = progLang.name
        useCaseLabel.text = progLang.useCase
        likeButton.setImage(UIImage(systemName: progLang.isFavorite ? "heart.fill" : "heart", withConfiguration: buttonImageConfig), for: .normal)
        isFavorite = progLang.isFavorite
    }
    
    private func setupLayout() {
        nameLabel.font = .boldSystemFont(ofSize: 20)
        useCaseLabel.font = .systemFont(ofSize: 16)
        useCaseLabel.numberOfLines = 0
        
        let labelStack = UIStackView(arrangedSubviews: [nameLabel, useCaseLabel])
        labelStack.axis = .vertical
        labelStack.spacing = 2

        likeButton.tintColor = .systemRed
        likeButton.addTarget(self, action: #selector(likeTapped), for: .touchUpInside)
        
        [iconView, labelStack, likeButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
                iconView.widthAnchor.constraint(equalToConstant: 30),
                iconView.heightAnchor.constraint(equalToConstant: 30),
                iconView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                iconView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),

                labelStack.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 16),
                labelStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
                labelStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
                labelStack.trailingAnchor.constraint(equalTo: likeButton.leadingAnchor, constant: -16),

                likeButton.widthAnchor.constraint(equalToConstant: 30),
                likeButton.heightAnchor.constraint(equalToConstant: 30),
                likeButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                likeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
            ])
    }
    
    @objc private func likeTapped() {
        isFavorite.toggle()
        likeButton.setImage(UIImage(systemName: isFavorite ? "heart.fill" : "heart", withConfiguration: buttonImageConfig), for: .normal)
    }
}
