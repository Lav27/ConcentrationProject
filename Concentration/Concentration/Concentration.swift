//
//  Concentration.swift
//  Concentration
//
//  Created by R, Lavanya on 2/21/18.
//  Copyright © 2018 R, Lavanya. All rights reserved.
//

import Foundation


struct Concentration{
    var noOfPairsOfCards: Int = 0
    var cards = [Card]()
    var seenCards = (Set<Int>)()
      var scoreNow = 0
    struct Points{
        var increment = 2
        var decrement = 1
    }
    var indexOfOneAndOnlyCard: Int?{
        get
        {
            return cards.indices.filter { cards[$0].faceUp}.oneAndOnly
            }
    
//
//        var index: Int?
//        for i in cards.indices{
//        if cards[i].faceUp{
//            if index == nil{
//                index = i
//            }
//            else{
//                index = nil
//            }
//        }
//        }
//            return index
        
        set
        {
            for index in cards.indices{
                cards[index].faceUp = index == newValue
            }
        }
    }
   mutating func chooseCard(at index: Int)
    {
        if !cards[index].isMatched{
            if let matchIndex = indexOfOneAndOnlyCard , matchIndex != index{
                if cards[index] == cards[matchIndex]
                {
                    cards[index].isMatched = true
                    cards[matchIndex].isMatched = true
                    scoreNow+=2
                }
                else
                {
                    if seenCards.contains(index){
                        scoreNow-=1
                    }
                    if seenCards.contains(matchIndex){
                        scoreNow-=1
                    }
                    seenCards.insert(index)
                    seenCards.insert(matchIndex)
                    
                }
                cards[index].faceUp = true
                
         //indexOfOneAndOnlyCard = nil
            }
           
            else{
                indexOfOneAndOnlyCard = index
            }
        }
    }
    mutating func reset(){
        for index in cards.indices{
            cards[index].faceUp=false
            cards[index].isMatched=false
        }
        cards.shuffle()
        scoreNow = 0
    }
    init(noOfCards:Int) {
        noOfPairsOfCards = noOfCards
        for _ in 0..<noOfPairsOfCards{
            let card = Card()
            cards+=[card,card]
        }
        cards.shuffle()
    }
    
}
extension Collection{
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
}
}
extension Array{
    mutating func shuffle(){
        if count < 2
        { return
        }
        for i in indices.dropLast(){
            let diff = distance(from: i, to: endIndex)
            let j = index(i, offsetBy: diff.arc4Random)
            swapAt(i,j)
        }
        
    }
}

