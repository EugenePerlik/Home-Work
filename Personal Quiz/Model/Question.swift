//
//  Question.swift
//  Personal Quiz
//
//  Created by  Apple24 on 06/12/2018.
//  Copyright © 2018  Apple24. All rights reserved.
//

import Foundation


struct Question {
    var text: String
    var type: ResponseType
    var answers: [Answer]
}

enum ResponseType {
    case single, multiple, ranged
    
}

struct Answer {
    var text: String
    var type: AnimalType
}

enum AnimalType: Character {
    case dog = "🐶", cat = "🐱", rabbit = "🐰", turtle = "🐢"
    
    var definition: String {
        switch self {
        case .dog:
            return "Вы любите бывать в компании. Вы всегда окружены друзьями. Вам наравиться играть и быть другом для всех."
        case .cat:
            return "Вы гуляете сами по себе. Вам нравиться свобода и самостоятельность."
        case .rabbit:
            return "Вам наравиться всё мягкое. Вы здоровы и полны энергии."
        case .turtle:
            return "Вы мудры не по годам. Медленный и вдумчивый выигрывает гонку.  Тише едешь, дальше будешь."
        }
    }
}
