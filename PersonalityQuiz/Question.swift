//
//  Question.swift
//  PersonalityQuiz
//
//  Created by Aditya Gupta on 24/09/24.
//

import UIKit
struct Question{
    var text : String
    var type : ResponseType
    var answers : [Answer]
    
}

struct QuestionAot{
    var text : String
    var type : ResponseType
    var answers : [AnswerAot]
}

enum ResponseType {
    case Single, Multiple, Ranged
}

struct Answer {
    var text : String
    var type : NakamaType
}

struct AnswerAot {
    var text : String
    var type : AotType
}

enum AotType : String {
    case Eren = "Eren Yeager", Mikasa = "Mikasa Ackerman", Armin = "Armin Arlert", Levi = "Levi Ackerman", Erwin = "Erwin Smith"
}

enum NakamaType : String {
    case Luffy = "Monkey D. Luffy", Zoro = "Roronoa Zoro", Nami = "Nami", Ussop =
"God Ussop", Sanji = "Vinnsmoke Sanji", Chopper = "Tony Tony Chopper", Robin = "Nico Robin", Franky = "Franky", Brooks = "S.K. Brooks", Jinbe = "Jinbe";
    
    var definition : String {
        switch self{
            case .Luffy :
                return "The Brave, stupid and very determined Captain of the Straw hat Pirates."
            case .Zoro :
                return "The Strong and Honorable First Mate of the Strawhat Pirates"
            case .Nami :
                return "Beautiful and smart, The Navigator of the Strawhat Pirates"
            case .Ussop :
                return "Genius but scaredy, The Sniper of the Strawhat Pirates"
            case .Sanji :
                return "Amazing Cook and a Ladies Man, The Cook of the Strawhat Pirates"
            case .Chopper :
                return "Smart and Cute, The Doctor of the Strawhat Pirates"
            case .Robin :
                return "The Most Beautiful Nerd, The Archiologist of the Strawhat Pirates"
            case .Franky :
                return "Smart and Crafty, The Builder of the Strawhat Pirates"
            case .Brooks :
                return "Melodius and dead Inside, The Musician of The Strawhat Pirates"
        case .Jinbe :
                return "Sensible and The Voice of reason, The Helmsman of The Strawhat Pirates"
            }
    }
    
}
