//
//  TableViewController.swift
//  UITableHomeWork
//
//  Created by Артём Сноегин on 13.08.2025.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DataUpdaterDelegate {
    
    private var allLanguages = programmingLanguages
    private var deletedLanguages = [ProgrammingLanguage]()
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    
    private enum Section: Int, CaseIterable {
        case languages
        case indexes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureNavigationBar()
        configureTableView()
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "Programming Languages"
        
        navigationItem.rightBarButtonItem = editButtonItem
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(restoreLanguage))
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: animated)
    }
    
    @objc private func restoreLanguage() {
        let nextVC = CollectionViewController(data: deletedLanguages)
        nextVC.dataUpdater = self
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func restoreItem(item: ProgrammingLanguage) {
        
        allLanguages.append(item)
        deletedLanguages.removeAll { programmingLanguage in
            programmingLanguage.name == item.name
        }
        let newIndexPath = IndexPath(row: allLanguages.count - 1, section: Section.languages.rawValue)
        
        tableView.performBatchUpdates {
                tableView.insertRows(at: [newIndexPath], with: .automatic)
                // Обновляем секцию indexes, чтобы индексы пересчитались
                tableView.reloadSections([Section.indexes.rawValue], with: .automatic)
            }
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.reuseIdentifier)
        
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
            let programmingLanguage = allLanguages[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.reuseIdentifier, for: indexPath) as! TableViewCell
            cell.dataUpdater = self
            cell.configure(programmingLanguage)

            return cell
        }
    }
    
    func editState(in cell: TableViewCell, with state: Bool) {
        guard let newIndexPath = tableView.indexPath(for: cell) else { return }
        allLanguages[newIndexPath.row].isFavorite = state
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if let section = Section(rawValue: indexPath.section) {
            if section == Section.indexes {
                return false
            }
        }
        return true
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
                case .indexes:
                    return
                case .languages:
                    deletedLanguages.append(allLanguages[indexPath.row])
                    allLanguages.remove(at: indexPath.row)
                    tableView.performBatchUpdates {
                        tableView.deleteRows(at: [indexPath], with: .automatic)
                        tableView.reloadSections([Section.indexes.rawValue], with: .automatic)
                    }
                }
            }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let progLang = allLanguages[indexPath.row]
        navigationController?.pushViewController(DetailViewController(languageInfo: progLang), animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

