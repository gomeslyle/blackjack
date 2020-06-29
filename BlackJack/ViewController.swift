//
//  ViewController.swift
//  BlackJack
//
//  Created by Admin on 2020-06-28.
//  Copyright © 2020 Admin. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var WelcomeToBlackJackTextField: NSTextField!
    @IBOutlet weak var BlackJackImage: NSImageView!
    
    @IBOutlet weak var DealButton: NSButton!
    @IBOutlet weak var StandButton: NSButton!
    @IBOutlet weak var HitButton: NSButton!
    
    @IBOutlet weak var PlayerCard1: NSImageView!
    @IBOutlet weak var PlayerCard2: NSImageView!
    @IBOutlet weak var PlayerCard3: NSImageView!
    @IBOutlet weak var PlayerCard4: NSImageView!
    @IBOutlet weak var PlayerCard5: NSImageView!
    @IBOutlet weak var PlayerCard6: NSImageView!
    @IBOutlet weak var PlayerCard7: NSImageView!
    @IBOutlet weak var PlayerCard8: NSImageView!
    @IBOutlet weak var PlayerCard9: NSImageView!
    
    @IBOutlet weak var DealerCard1: NSImageView!
    @IBOutlet weak var DealerCard2: NSImageView!
    @IBOutlet weak var DealerCard3: NSImageView!
    @IBOutlet weak var DealerCard4: NSImageView!
    @IBOutlet weak var DealerCard5: NSImageView!
    @IBOutlet weak var DealerCard6: NSImageView!
    @IBOutlet weak var DealerCard7: NSImageView!
    @IBOutlet weak var DealerCard8: NSImageView!
    @IBOutlet weak var DealerCard9: NSImageView!

    var PlayersCardsImageViews = [NSImageView!]()
    var DealersCardsImageViews = [NSImageView!]()
    
    @IBOutlet weak var DealerScoreTextField: NSTextField!
    @IBOutlet weak var PlayerScoreTextField: NSTextField!
    @IBOutlet weak var MatchResult: NSTextField!
    
    var deck = Deck()
    var DeckIndex = Int()
    
    var PlayersScore = Int()
    var DealersScore = Int()
    var DisplayedDealersScore = Int()
    
    var PlayersHand = [Card]()
    var DealersHand = [Card]()
    
    var FirstHand = BooleanLiteralType()
    var NumberOfMatchesPlayed = Int()
    var PlayerWonMatch = BooleanLiteralType()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        for c in self.deck.Cards {
            print(c.rank.rawValue + " " + c.suit.rawValue + " " + String(c.value))
        }
        self.NumberOfMatchesPlayed = -1
        self.imageViewsArrayInit()
        self.hideEndOfMatchViews()
        self.hideGameTimeViews()
        self.startNewGame()
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    func imageViewsArrayInit() {
        self.PlayersCardsImageViews.append(self.PlayerCard1)
        self.PlayersCardsImageViews.append(self.PlayerCard2)
        self.PlayersCardsImageViews.append(self.PlayerCard3)
        self.PlayersCardsImageViews.append(self.PlayerCard4)
        self.PlayersCardsImageViews.append(self.PlayerCard5)
        self.PlayersCardsImageViews.append(self.PlayerCard6)
        self.PlayersCardsImageViews.append(self.PlayerCard7)
        self.PlayersCardsImageViews.append(self.PlayerCard8)
        self.PlayersCardsImageViews.append(self.PlayerCard9)
        self.DealersCardsImageViews.append(self.DealerCard1)
        self.DealersCardsImageViews.append(self.DealerCard2)
        self.DealersCardsImageViews.append(self.DealerCard3)
        self.DealersCardsImageViews.append(self.DealerCard4)
        self.DealersCardsImageViews.append(self.DealerCard5)
        self.DealersCardsImageViews.append(self.DealerCard6)
        self.DealersCardsImageViews.append(self.DealerCard7)
        self.DealersCardsImageViews.append(self.DealerCard8)
        self.DealersCardsImageViews.append(self.DealerCard9)
    }
    
    @IBAction func DealAction(_ sender: NSButton) {
        self.hideOpenningScreenViews()
        self.hideEndOfMatchViews()
        self.showGameTimeViews()
        self.considerReshuffle()
        self.dealHand()
    }
    
    @IBAction func StandAction(_ sender: NSButton) {
        self.makeDealersDecision()
    }
    
    @IBAction func HitAction(_ sender: NSButton) {
        self.playerHits()
    }
    
    func hideOpenningScreenViews() {
        BlackJackImage.isHidden              = true
        WelcomeToBlackJackTextField.isHidden = true
        DealButton.isHidden                  = true
    }
    
    func showGameTimeViews() {
        PlayerCard1.isHidden                 = false
        PlayerCard2.isHidden                 = false
        PlayerCard3.isHidden                 = true
        PlayerCard4.isHidden                 = true
        PlayerCard5.isHidden                 = true
        PlayerCard6.isHidden                 = true
        DealerCard1.isHidden                 = false
        DealerCard2.isHidden                 = false
        DealerCard3.isHidden                 = true
        DealerCard4.isHidden                 = true
        DealerCard5.isHidden                 = true
        DealerCard6.isHidden                 = true
        PlayerScoreTextField.isHidden        = false
        DealerScoreTextField.isHidden        = false
        HitButton.isHidden                   = false
        StandButton.isHidden                 = false
    }
    
    func hideGameTimeViews() {
        DealerCard1.isHidden                 = true
        DealerCard2.isHidden                 = true
        PlayerCard1.isHidden                 = true
        PlayerCard2.isHidden                 = true
        PlayerScoreTextField.isHidden        = true
        DealerScoreTextField.isHidden        = true
        HitButton.isHidden                   = true
        StandButton.isHidden                 = true
    }
    
    func showEndOfMatchViews() {
        HitButton.isHidden                   = true
        StandButton.isHidden                 = true
        MatchResult.isHidden                 = false
        DealButton.isHidden                  = false
    }
    
    func hideEndOfMatchViews() {
        HitButton.isHidden                   = false
        StandButton.isHidden                 = false
        MatchResult.isHidden                 = true
    }
    
    func startNewGame() {
        self.FirstHand = true
        self.PlayersScore = 0
        self.DealersScore = 0
        self.DisplayedDealersScore = 0
        self.DeckIndex = 51
        self.PlayersHand = [Card]()
        self.DealersHand = [Card]()
    }
    
    func considerReshuffle() {
        if self.NumberOfMatchesPlayed % 6 == 0 {
            self.deck.reshuffleDeck()
            self.DeckIndex = 51
        }
    }
    
    func dealNewHand() {
        
    }
    
    /*
     ------------- note from stack -------------
     Thanks to KPM and WolfLink for pointing out that let result = array.dropFirst(n) sets result to an ArraySlice,
     which will not remain valid if the original array is released.
     */
    
    func dealHand() {
        
        self.NumberOfMatchesPlayed += 1
        
        var dealtCards = [Card]()
        for i in stride(from:self.DeckIndex, to: self.DeckIndex-4, by: -1) {
            dealtCards.append(self.deck.Cards[i])
            self.DeckIndex -= 1
        }
        
        let PlayersCards = [dealtCards[0], dealtCards[2]]
        let DealersCards = [dealtCards[1], dealtCards[3]]
        
        self.PlayersHand = PlayersCards
        self.DealersHand = DealersCards
        
        self.PlayersScore = PlayersCards[0].value + PlayersCards[1].value
        self.DealersScore = DealersCards[0].value + DealersCards[1].value
        self.DisplayedDealersScore = DealersCards[0].value
        
        let PlayerCard1Name = NSImage.Name(PlayersCards[0].rank.rawValue + PlayersCards[0].suit.rawValue)
        let PlayerCard2Name = NSImage.Name(PlayersCards[1].rank.rawValue + PlayersCards[1].suit.rawValue)
        let DealerCard1Name = NSImage.Name(DealersCards[0].rank.rawValue + DealersCards[0].suit.rawValue)
        // let DealersHiddenCard = NSImage.Name("gray_back")
        let DealersHiddenCard = NSImage.Name(DealersCards[1].rank.rawValue + DealersCards[1].suit.rawValue)
        
        PlayerCard1.image = NSImage(named: PlayerCard1Name)
        PlayerCard2.image = NSImage(named: PlayerCard2Name)
        DealerCard1.image = NSImage(named: DealerCard1Name)
        DealerCard2.image = NSImage(named: DealersHiddenCard)
        
        PlayerScoreTextField.stringValue = String(self.PlayersScore)
        DealerScoreTextField.stringValue = String(self.DealersScore)
    }
    
    func makeDealersDecision() {
        
    }
    
    func playerHits() {
        let playersNextCard = self.deck.Cards[self.DeckIndex]
        self.PlayersHand.append(playersNextCard)
        self.PlayersScore += playersNextCard.value
        PlayerScoreTextField.stringValue = String(self.PlayersScore)
        let playersNextCardName = NSImage.Name(playersNextCard.rank.rawValue + playersNextCard.suit.rawValue)
        for v in self.PlayersCardsImageViews {
            if (v?.isHidden)! {
                v?.image = NSImage(named: playersNextCardName)
                v?.isHidden = false
                break
            }
        }
        self.DeckIndex -= 1
        self.findResultOfMatch()
        //        for c in self.deck.Cards {
        //          print(c.rank.rawValue + " " + c.suit.rawValue + " " + String(c.value))
        //        }
    }
    
    func dealerHits() {
        
    }
    
    func findResultOfMatch() {
        var playersScoreWithoutAces = 0
        var numberOfAcesInPlayersHand = 0
        for c in self.PlayersHand {
            if c.rank == Rank.Ace {
                numberOfAcesInPlayersHand += 1
            } else {
                playersScoreWithoutAces += c.value
            }
        }
        print("numberOfAcesInPlayersHand: " + String(numberOfAcesInPlayersHand))
        print("playersScoreWithoutAces: " + String(playersScoreWithoutAces))

        var validScores = [Int]()
        for numberOfAcesCountedAsEleven in 0...numberOfAcesInPlayersHand {
            let score = playersScoreWithoutAces + numberOfAcesCountedAsEleven*11 + numberOfAcesInPlayersHand - numberOfAcesCountedAsEleven
            if score <= 21 {
                validScores.append(score)
            }
        }

        var maxValidScore = -1
        for vs in validScores {
            print("a valid score: " + String(vs))
            if vs > maxValidScore {
                maxValidScore = vs
            }
        }

        if maxValidScore != -1 {
            self.PlayersScore = maxValidScore
            self.PlayerScoreTextField.stringValue = String(self.PlayersScore)
        } else if self.PlayersScore >= 21 {
            MatchResult.stringValue = "Dealer wins"
            self.PlayerScoreTextField.stringValue = String(self.PlayersScore)
            self.showEndOfMatchViews()
        }

    }
    
    //for c in self.deck.Cards {
    //  print(c.rank.rawValue + " " + c.suit.rawValue + " " + String(c.value))
    //}
    
    
}

