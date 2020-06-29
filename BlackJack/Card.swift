//
//  Card.swift
//  BlackJack
//
//  Created by Admin on 2020-06-28.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

public enum Suit : String {
    case Diamond = "D"
    case Club = "C"
    case Heart = "H"
    case Spade = "S"
    static let AllSuits = [Diamond, Club, Heart, Spade]
}

public enum Rank : String {
    case Two = "2"
    case Three = "3"
    case Four = "4"
    case Five = "5"
    case Six = "6"
    case Seven = "7"
    case Eight = "8"
    case Nine = "9"
    case Ten = "10"
    case Jack = "J"
    case Queen = "Q"
    case King = "K"
    case Ace = "A"
    static let AllRanks = [Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten, Jack, Queen, King, Ace]
}

public struct Card {
    let suit: Suit
    let rank: Rank
    let value: Int
}

class Deck {
    var Cards: [Card]
    init () {
        self.Cards = [Card]()
        for s in Suit.AllSuits {
            var v: Int
            v = 2
            for r in Rank.AllRanks {
                let card: Card
                card = Card(suit: s, rank: r, value: v)
                self.Cards.append(card)
                if (r == Rank.Ten || r == Rank.Jack || r == Rank.Queen) {
                    // Pass
                } else if (r == Rank.King) {
                    v = 11
                } else {
                    v += 1
                }
            }
        }
        self.Cards = self.shuffleDeck()
    }
    func shuffleDeck() -> [Card] {
        var shuffledDeck = [Card]()
        for _ in self.Cards {
            let randomNumber = Int(arc4random_uniform(UInt32(self.Cards.count-1)))
            shuffledDeck.append(self.Cards[randomNumber])
            self.Cards.remove(at: randomNumber)
        }
        shuffledDeck.reverse()
        return shuffledDeck
    }
}
