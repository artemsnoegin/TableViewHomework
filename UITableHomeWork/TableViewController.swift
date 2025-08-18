//
//  TableViewController.swift
//  UITableHomeWork
//
//  Created by Артём Сноегин on 13.08.2025.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    private enum Section: Int, CaseIterable {
        case indexes
        case languages
    }
    
    private var allLanguages = programmingLanguages
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureNavigationBar()
        configureTableView()
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "Programming Languages"
        
        navigationItem.rightBarButtonItem = editButtonItem
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: animated)
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ProgrammingLanguageCell.self, forCellReuseIdentifier: "ProgrammingLanguageCell")
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let section = Section(rawValue: section) else { return "" }
        
        switch section {
        case .indexes: return "Индексы"
        case .languages: return "Языки программирования"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allLanguages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = Section(rawValue: indexPath.section) else { return UITableViewCell() }
        let progLang = allLanguages[indexPath.row]
        
        switch section {
        case .indexes:
            let defaultCell = UITableViewCell()
            var config = defaultCell.defaultContentConfiguration()
            
            config.text = progLang.name
            config.textProperties.font = .boldSystemFont(ofSize: 20)
            config.secondaryText = "Индекс: \(indexPath.row)"
            config.secondaryTextProperties.font = .systemFont(ofSize: 16)
            config.image = progLang.icon
            config.imageProperties.maximumSize = CGSize(width: 30, height: 30)
            
            defaultCell.contentConfiguration = config
            
            return defaultCell
            
        case .languages:
            let progLang = allLanguages[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProgrammingLanguageCell", for: indexPath) as! ProgrammingLanguageCell
            cell.configureCell(progLang)

            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let progLang = allLanguages[sourceIndexPath.row]
        allLanguages.remove(at: sourceIndexPath.row)
        allLanguages.insert(progLang, at: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let section = Section(rawValue: indexPath.section) else { return }
        if editingStyle == .delete {
            switch section {
            case .indexes: return
            case .languages:
                allLanguages.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let progLang = allLanguages[indexPath.row]
        navigationController?.pushViewController(DetailViewController(languageInfo: progLang), animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

