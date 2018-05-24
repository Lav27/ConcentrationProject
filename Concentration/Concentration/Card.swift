//
//  Card.swift
//  Concentration
//
//  Created by R, Lavanya on 2/21/18.
//  Copyright © 2018 R, Lavanya. All rights reserved.
//

import Foundation

struct Card: Hashable{
    var hashValue: Int
    {
        return identifier
    }
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    var isMatched = false
    var faceUp = false
    var identifier: Int
    
    static var sid = 0
    static func getUniqueId()-> Int{
        sid+=1
        return sid
    }
    init()
    {
        identifier = Card.getUniqueId()
    }


}
