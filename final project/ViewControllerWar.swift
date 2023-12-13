//
//  ViewControllerWar.swift
//  final project
//
//  Created by OLIVER MURRAY on 12/6/23.
//

import UIKit

class ViewControllerWar: UIViewController {

    
    var delegate : ViewControllerDelegate!
    
    @IBOutlet weak var userDice: UIImageView!
    
    @IBOutlet weak var compDice: UIImageView!
    
    @IBOutlet weak var roundLabel: UILabel!
    
    @IBOutlet weak var recordOutlet: UILabel!
    
    @IBOutlet weak var moneyOutlet: UILabel!
    
    @IBOutlet weak var betOutlet: UILabel!
    
    var bet = 0
    
    var wins = 0
    
    var loses = 0
    
    var keep = 0
    
    var round = 0
    
    var curWins = 0
    
    var curLoses = 0
    
    var dices = [Dice(pic: "dice1.png", num: 1), Dice(pic:
            "dice2.png", num: 2), Dice(pic: "dice3.png", num: 3), Dice(pic: "dice4.png", num: 4), Dice(pic: "dice5.png", num: 5), Dice(pic: "dice6.png", num: 6)]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        money = delegate.show()
        moneyOutlet.text = "$\(money)"
    }
    

    @IBAction func rollAction(_ sender: Any) {
        
        keep = 0
        let user = Int.random(in: 1...6)
        let comp = Int.random(in: 1...6)
        
        userDice.image = UIImage(named: dices[user - 1].pic)
        compDice.image = UIImage(named: dices[comp - 1].pic)
        if bet <= delegate.show(){
            while(keep == 0){
                
                
                if user > comp{
                    curWins = curWins + 1
                    keep = 1
                    roundLabel.text = "Current Round Wins: \(curWins) Loses: \(curLoses)"
                    
                }
                else if comp > user{
                    curLoses = curLoses + 1
                    keep = 1
                    roundLabel.text = "Current Round Wins: \(curWins) Loses: \(curLoses)"
                }
                else{
                    let alert = UIAlertController(title: "Draw", message: "Roll Again", preferredStyle: .alert)
                    
                    let okAction = UIAlertAction(title: "ok", style: .default, handler: nil)
                    
                    alert.addAction(okAction)
                    
                    present(alert, animated: true, completion: nil)
                    break
                    
                }
            } //end of while
        }
        else{
            
            let alert = UIAlertController(title: "Invalid", message: "Can't bet more than you own", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "ok", style: .default, handler: nil)
            
            alert.addAction(okAction)
            
            present(alert, animated: true, completion: nil)
            
        }
        if curWins == 3{
            wins += 1
            keep = 0
            curWins = 0
            curLoses = 0
            delegate.add(cash: bet)
            delegate.dAdd(cash: bet)
            recordOutlet.text = "Wins: \(wins) Loses: \(loses)"
        }
        else if curLoses == 3{
        loses += 1
            keep = 0
            curWins = 0
            curLoses = 0
            delegate.remove(cash: bet)
            delegate.dRemove(cash: bet)
            roundLabel.text = "Current Round Wins: \(curWins) Loses: \(curLoses)"
        }
        
        money = delegate.show()
        moneyOutlet.text = "$\(money)"
    } //end of roll
    

    
    
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


