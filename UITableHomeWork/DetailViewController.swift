//
//  DetailViewController.swift
//  UITableHomeWork
//
//  Created by Артём Сноегин on 17.08.2025.
//

import UIKit

class DetailViewController: UIViewController {
    
    private let languageInfo: ProgrammingLanguage
    
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let iconView = UIImageView()
    private let isFavoriteMark = UIImageView()
    
    init(languageInfo: ProgrammingLanguage) {
        self.languageInfo = languageInfo
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor =  .systemBackground
        
        setUpUI()
    }
    
    private func setUpUI() {
        title = languageInfo.name
        
        iconView.image = languageInfo.icon
        let iconSize = view.frame.width - 32
        
        titleLabel.text = languageInfo.name
        titleLabel.font = .boldSystemFont(ofSize: 32)
        
        descriptionLabel.text = languageInfo.useCase
        descriptionLabel.font = .systemFont(ofSize: 22)
        descriptionLabel.numberOfLines = 0
        
        if languageInfo.isFavorite {
            isFavoriteMark.image = UIImage(systemName: "heart.fill")
            isFavoriteMark.tintColor = .systemRed
        } else {
            isFavoriteMark.image = UIImage()
        }
        
        [titleLabel, descriptionLabel, iconView, isFavoriteMark].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            iconView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 18),
            iconView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            iconView.widthAnchor.constraint(equalToConstant: iconSize),
            iconView.heightAnchor.constraint(equalToConstant: iconSize),
            
            titleLabel.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 18),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            isFavoriteMark.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            isFavoriteMark.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            isFavoriteMark.widthAnchor.constraint(equalTo: isFavoriteMark.heightAnchor),
            isFavoriteMark.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
}
