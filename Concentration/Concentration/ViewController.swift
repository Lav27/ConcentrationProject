//
//  ViewController.swift
//  Concentration
//
//  Created by R, Lavanya on 2/21/18.
//  Copyright © 2018 R, Lavanya. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var score: UILabel!
   lazy var game = Concentration(noOfCards: noOfCards)
    var noOfCards: Int{
        return (cardButton.count / 2)
    }
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBAction func newGame(_ sender: UIButton) {
  
    game.reset()
        updateViewFromModel()
        flipCount = 0
        indexTheme = emojiThemes.count.arc4Random
        
    }
    private struct Theme{
        var name: String
        var emojis: [String]
        var viewColor: UIColor
        var cardColor: UIColor
    }
    private var emojiThemes: [Theme] = [
        Theme(name: "Fruits",
              emojis: ["🍏", "🍊", "🍓", "🍉", "🍇", "🍒", "🍌", "🥝", "🍆", "🍑", "🍋"],
            viewColor: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1),
            cardColor: #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)),
    Theme(name: "Faces",
          emojis:["😀", "😂", "🤣", "😃", "😄", "😅", "😆", "😉", "😊", "😋", "😎"],
    viewColor: #colorLiteral(red: 1, green: 0.8999392299, blue: 0.3690503591, alpha: 1),
    cardColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)),
    Theme(name: "Activity",
    emojis:["⚽️", "🏄‍♂️", "🏑", "🏓", "🚴‍♂️","🥋", "🎸", "🎯", "🎮", "🎹", "🎲"],
    viewColor: #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1),
    cardColor: #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)),
    Theme(name: "Animals",
    emojis:["🐶", "🐭", "🦊", "🦋", "🐢", "🐸", "🐵", "🐞", "🐿", "🐇", "🐯"],
    viewColor: #colorLiteral(red: 0.8306297664, green: 1, blue: 0.7910112419, alpha: 1),
    cardColor: #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)),
    Theme(name: "Christmas",
    emojis:["🎅", "🎉", "🦌", "⛪️", "🌟", "❄️", "⛄️","🎄", "🎁", "🔔", "🕯"],
    viewColor: #colorLiteral(red: 0.9678710938, green: 0.9678710938, blue: 0.9678710938, alpha: 1),
    cardColor: #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)),
    Theme(name: "Clothes",
    emojis:["👚", "👕", "👖", "👔", "👗", "👓", "👠", "🎩", "👟", "⛱","🎽"],
    viewColor: #colorLiteral(red: 0.9098039269, green: 0.7650054947, blue: 0.8981300767, alpha: 1),
    cardColor: #colorLiteral(red: 0.5818830132, green: 0.2156915367, blue: 1, alpha: 1)),
    Theme(name: "Halloween",
    emojis:["💀", "👻", "👽", "🙀", "🦇", "🕷", "🕸", "🎃", "🎭","😈", "⚰"],
    viewColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
    cardColor: #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)),
    Theme(name: "Transport",
    emojis:["🚗", "🚓", "🚚", "🏍", "✈️", "🚜", "🚎", "🚲", "🚂", "🛴"],
    viewColor: #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1),
    cardColor: #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1))
    ]
        
    private var indexTheme=0 {
        didSet {
            print(emojiThemes[indexTheme].name)
            emojis = [Card:String]()
            titleLabel.text = emojiThemes[indexTheme].name
            emojiChoices =  emojiThemes[indexTheme].emojis
            backgroundColor = emojiThemes[indexTheme].viewColor
            cardColor = emojiThemes[indexTheme].cardColor
            updateApperance()
        }
    }
    private var backgroundColor = UIColor.black
    private var cardColor = UIColor.orange
        
    func  updateApperance(){
        view.backgroundColor = backgroundColor
        flipsCountLabel.textColor = cardColor
        score.textColor = cardColor
        titleLabel.textColor = cardColor
        
    }
    
   
    
    
    
    
    
  
    @IBOutlet var cardButton: [UIButton]!
    var flipCount = 0 {
        didSet
        {
            updateFlipCountLabel()
        }
    }
    
    @IBOutlet weak var flipsCountLabel: UILabel!
    {
        didSet{
            updateFlipCountLabel()
        }
    }
   
    func updateFlipCountLabel(){
        let attributes: [NSAttributedStringKey: Any] = [
            .strokeWidth: 5.0 ,
            .strokeColor: #colorLiteral(red: 0.0723565174, green: 0.1325436814, blue: 1, alpha: 1)
            
        ]
        let attributedString = NSAttributedString(string: "Flips: \(flipCount)", attributes: attributes)
        flipsCountLabel.attributedText = attributedString
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let index = cardButton.index(of: sender){
            flipCount+=1
            game.chooseCard(at: index)
            updateViewFromModel()
        }
    
    
    }
    func updateViewFromModel(){
        for index in cardButton.indices{
            let button = cardButton[index]
            let card = game.cards[index]
            if(card.faceUp == true)
            {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 0) : #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
            }
            else
            {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 0) : #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
            }
        }
        score.text = "Score : \(game.scoreNow)"
        
    }
    var emojiChoices=[""]
   //var emojiChoices = ["🦇", "😱", "🙀", "😈", "🎃", "👻", "🍭", "🍬", "🍎"]
   
    var emojis = [Card:String]()
    func emoji(for card: Card)-> String
    {
        if emojis[card] == nil{
            let index = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4Random)
            emojis[card] = String(emojiChoices.remove(at: index))
        }
        return emojis[card] ?? "?"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
         indexTheme = emojiThemes.count.arc4Random
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
extension Int{
    var arc4Random: Int{
        if self > 0{
            return Int(arc4random_uniform(UInt32(self)))}
        else if self < 0{
            return -Int(arc4random_uniform(UInt32(self)))}
        else{
            return 0}
        
    }
}
