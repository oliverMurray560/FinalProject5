//
//  ViewControllerGame.swift
//  final project
//
//  Created by OLIVER MURRAY on 12/6/23.
//

import UIKit

class ViewControllerGame: UIViewController {

    @IBOutlet weak var logOutlet: UITextView!
    @IBOutlet weak var recordOutlet: UILabel!
    @IBOutlet weak var leftDice: UIImageView!
    @IBOutlet weak var rightDice: UIImageView!
    
    @IBOutlet weak var moneyOutlet: UILabel!
    @IBOutlet weak var betOutlet: UILabel!
    
    var delegate : ViewControllerDelegate!
    var wins = 0
    var loses = 0
    var loopCount = 1
    var gameCount = 0
    var dt : String = ""
    var bet = 0
    var rollCount = 1
    
    var sum : Int = 0
    var dices = [Dice(pic: "dice1.png", num: 1), Dice(pic:
            "dice2.png", num: 2), Dice(pic: "dice3.png", num: 3), Dice(pic: "dice4.png", num: 4), Dice(pic: "dice5.png", num: 5), Dice(pic: "dice6.png", num: 6)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        money = delegate.show()
        moneyOutlet.text = "$\(money)"
        
        //String(delegate.show())
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        money = delegate.show()
        moneyOutlet.text = "$\(money)"
    }
    @IBAction func rollAction(_ sender: Any) {
        if bet <= delegate.show(){
            if loopCount == 1{
                gameCount += 1
                let rand1 = Int.random(in: 1...6)
                let rand2 = Int.random(in: 1...6)
                
                leftDice.image = UIImage(named: dices[rand1 - 1].pic)
                rightDice.image = UIImage(named: dices[rand2 - 1].pic)
                let dye1 = dices[rand1 - 1].num
                let dye2 = dices[rand2 - 1].num
                sum = dye1 + dye2
                if sum == 2 || sum == 3 || sum == 12{
                    loses = loses + 1
                    delegate.remove(cash: bet)
                    delegate.dRemove(cash: bet)
                    dt += "game \(gameCount): role \(rollCount), \(dye1) + \(dye2): lost \n"
                    logOutlet.text = dt
                    let alert = UIAlertController(title: "End", message: "You lost", preferredStyle: .alert)
                    
                    let okAction = UIAlertAction(title: "ok", style: .default, handler: nil)
                    
                    alert.addAction(okAction)
                    
                    present(alert, animated: true, completion: nil)
                    
                }
                else if sum == 7 || sum == 11{
                    wins = wins + 1
                    delegate.add(cash: bet)
                    delegate.dAdd(cash: bet)
                    dt += "game \(gameCount): roll \(rollCount), \(dye1) + \(dye2): won \n"
                    logOutlet.text = dt
                    let alert = UIAlertController(title: "End", message: "You won!", preferredStyle: .alert)
                    
                    let okAction = UIAlertAction(title: "ok", style: .default, handler: nil)
                    
                    alert.addAction(okAction)
                    
                    present(alert, animated: true, completion: nil)
                }
                else{
                    loopCount += 1
                    dt += "game \(gameCount): roll \(rollCount), \(dye1) + \(dye2): continue \n"
                    logOutlet.text = dt
                    let alert = UIAlertController(title: "Continue", message: "Roll again", preferredStyle: .alert)
                    
                    let okAction = UIAlertAction(title: "ok", style: .default, handler: nil)
                    
                    alert.addAction(okAction)
                    
                    present(alert, animated: true, completion: nil)
                    rollCount += 1
                    
                }
                
                
            } //end loopCount 1
            else{ // loopCount 2
                
                let rand3 = Int.random(in: 1...6)
                let rand4 = Int.random(in: 1...6)
                
                leftDice.image = UIImage(named: dices[rand3 - 1].pic)
                rightDice.image = UIImage(named: dices[rand4 - 1].pic)
                let dye3 = dices[rand3 - 1].num
                let dye4 = dices[rand4 - 1].num
                let sum2 = dye3 + dye4
                
                if sum2 == sum{
                    wins = wins + 1
                    delegate.add(cash: bet)
                    delegate.dAdd(cash: bet)
                    dt += "game \(gameCount): roll \(rollCount), \(dye3) + \(dye4): won \n"
                    logOutlet.text = dt
                    let alert = UIAlertController(title: "End", message: "You won!", preferredStyle: .alert)
                    
                    let okAction = UIAlertAction(title: "ok", style: .default, handler: nil)
                    
                    alert.addAction(okAction)
                    
                    present(alert, animated: true, completion: nil)
                    rollCount = 1
                }
                else if sum2 == 7{
                    dt += "game \(gameCount): roll \(rollCount), \(dye3) + \(dye4): lost \n"
                    logOutlet.text = dt
                    loses = loses + 1
                    delegate.remove(cash: bet)
                    delegate.dRemove(cash: bet)
                    let alert = UIAlertController(title: "End", message: "You lost", preferredStyle: .alert)
                    
                    let okAction = UIAlertAction(title: "ok", style: .default, handler: nil)
                    
                    alert.addAction(okAction)
                    
                    present(alert, animated: true, completion: nil)
                    rollCount = 1
                    
                }
                else{
                    
                    
                    dt += "game \(gameCount): roll \(rollCount), \(dye3) + \(dye4): continue \n"
                    logOutlet.text = dt
                    let alert = UIAlertController(title: "Continue", message: "Roll again", preferredStyle: .alert)
                    
                    let okAction = UIAlertAction(title: "ok", style: .default, handler: nil)
                    
                    alert.addAction(okAction)
                    
                    present(alert, animated: true, completion: nil)
                  rollCount += 1
                }
                loopCount = 1
            } //end loopCount2
            
            recordOutlet.text = "Wins: \(wins) Loses: \(loses)"
            money = delegate.show()
            moneyOutlet.text = "$\(money)"
        }
        else{
            let alert = UIAlertController(title: "Invalid", message: "Can't bet more than you own", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "ok", style: .default, handler: nil)
            
            alert.addAction(okAction)
            
            present(alert, animated: true, completion: nil)

            
        }
    }//end of roll action
    
 
    @IBAction func increaseBet(_ sender: Any) {
        if bet < delegate.show(){
         bet += 10
        }
        betOutlet.text = "Place Bet $\(bet)"
    }
   
    @IBAction func decreaseBet(_ sender: Any) {
        if bet > 0{
            bet = bet - 10
        }
        betOutlet.text = "Place Bet $\(bet)"
    }
    
    
    
}
