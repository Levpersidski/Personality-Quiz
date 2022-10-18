//
//  Quastion.swift
//  Personality Quiz
//
//  Created by Роман Бакаев on 18.10.2022.
//

struct Question {
    let title: String
    let answers: [Answer]
    let type: ResponseType
}

struct Answer {
    let title: String
    let animal: Animal
}

enum ResponseType {
    case single
    case multiple
    case ranged
}

enum Animal: Character {
    case dog = "🐶"
    case cat = "🐱"
    case rabbit = "🐰"
    case turtle = "🐢"
}
