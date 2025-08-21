//
//  DataUpdaterDelegate.swift
//  UITableHomeWork
//
//  Created by Артём Сноегин on 20.08.2025.
//

import Foundation

protocol DataUpdaterDelegate: AnyObject {
    
    func restoreItem(item: ProgrammingLanguage)
    
    func editState(in cell: TableViewCell, with state: Bool)
    
}
