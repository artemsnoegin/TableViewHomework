//
//  ProgrammingLanguage.swift
//  UITableHomeWork
//
//  Created by Артём Сноегин on 13.08.2025.
//

import UIKit

struct ProgrammingLanguage {
    var name: String
    var useCase: String
    var icon: UIImage
    var isFavorite: Bool
}

private let defaultIcon = UIImage(systemName: "wrench.and.screwdriver.fill")?.withTintColor(.black, renderingMode: .alwaysOriginal) ?? UIImage()

let programmingLanguages: [ProgrammingLanguage] = [
    ProgrammingLanguage(
        name: "Python",
        useCase: "Data Science, Data Analyses, Backend",
        icon: UIImage(named: "python") ?? defaultIcon,
        isFavorite: true
    ),
    ProgrammingLanguage(
        name: "JavaScript",
        useCase: "Web Development, Frontend & Backend",
        icon: UIImage(named: "java-script") ?? defaultIcon,
        isFavorite: true
    ),
    ProgrammingLanguage(
        name: "Swift",
        useCase: "Apple Platforms",
        icon: UIImage(named: "swift") ?? defaultIcon,
        isFavorite: true
    ),
    ProgrammingLanguage(
        name: "Java",
        useCase: "Enterprise Apps, Android Development",
        icon: UIImage(named: "java") ?? defaultIcon,
        isFavorite: false
    ),
    ProgrammingLanguage(
        name: "C#",
        useCase: "Game Development, Enterprise Apps",
        icon: UIImage(named: "c-sharp") ?? defaultIcon,
        isFavorite: false
    ),
    ProgrammingLanguage(
        name: "C++",
        useCase: "Systems Programming, Games, High-Performance Apps",
        icon: UIImage(named: "c-") ?? defaultIcon,
        isFavorite: false
    ),
    ProgrammingLanguage(
        name: "Go",
        useCase: "Backend, High-Performance Services",
        icon: defaultIcon,
        isFavorite: true
    ),
    ProgrammingLanguage(
        name: "Kotlin",
        useCase: "Android Development",
        icon: UIImage(named: "android") ?? defaultIcon,
        isFavorite: false
    ),
    ProgrammingLanguage(
        name: "Objective-C",
        useCase: "Apple Development",
        icon: defaultIcon,
        isFavorite: false
    ),
    ProgrammingLanguage(
        name: "PHP",
        useCase: "Web Development, Backend",
        icon: UIImage(named: "php") ?? defaultIcon,
        isFavorite: true
    )
]

