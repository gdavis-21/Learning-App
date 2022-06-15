//
//  Question.swift
//  Learning-App
//
//  Created by Grant Davis on 6/15/22.
//

import Foundation

struct Question: Identifiable, Decodable {
    
    var id: Int
    var content: String
    var correctIndex: Int
    var answers: [String]
}
