//
//  ViewControllerG.swift
//  final project
//
//  Created by OLIVER MURRAY on 12/15/23.
//

import UIKit

class ViewControllerG: UIViewController {
    var guess : Int?
    var dices = [Dice(pic: "dice1.png", num: 1), Dice(pic:
            "dice2.png", num: 2), Dice(pic: "dice3.png", num: 3), Dice(pic: "dice4.png", num: 4), Dice(pic: "dice5.png", num: 5), Dice(pic: "dice6.png", num: 6)]
    var wins = 0
    var loses = 0
    var bet = 0
    @IBOutlet weak var guessOutlet: UITextField!
    
    @IBOutlet weak var oneOutlet: UIImageView!
    @IBOutlet weak var twoOutlet: UIImageView!
    @IBOutlet weak var threeOutlet: UIImageView!
    @IBOutlet weak var fourOutlet: UIImageView!
    @IBOutlet weak var fiveOutlet: UIImageView!
    @IBOutlet weak var sixOutlet: UIImageView!
    
    @IBOutlet weak var betOutlet: UILabel!
    @IBOutlet weak var moneyOutlet: UILabel!
    @IBOutlet weak var recordLabel: UILabel!
    
    
    
    var delegate : ViewControllerDelegate!
    override func viewDidLoad() {
        super.viewDidLoad()
        money = delegate.show()
        moneyOutlet.text = "$\(money)"
        moneyOutlet.text = "$\(money)"
        wins = defaults.integer(forKey: "x")
        loses = defaults.integer(forKey: "z")
        recordLabel.text = "Wins: \(wins) Loses: \(loses)"
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        money = delegate.show()
        moneyOutlet.text = "$\(money)"
    }
    
    
    @IBAction func submitAction(_ sender: Any) {
        
        if bet <= delegate.show(){
            guess = Int(guessOutlet.text!)
            if let g = guess{
                
                let rand1 = Int.random(in: 1...6)
                let rand2 = Int.random(in: 1...6)
                let rand3 = Int.random(in: 1...6)
                let rand4 = Int.random(in: 1...6)
                let rand5 = Int.random(in: 1...6)
                let rand6 = Int.random(in: 1...6)
                let record = rand1 + rand2 + rand3 + rand4 + rand5 + rand6
                
                oneOutlet.image = UIImage(named: dices[rand1 - 1].pic)
                twoOutlet.image = UIImage(named: dices[rand2 - 1].pic)
                threeOutlet.image = UIImage(named: dices[rand3 - 1].pic)
                fourOutlet.image = UIImage(named: dices[rand4 - 1].pic)
                fiveOutlet.image = UIImage(named: dices[rand5 - 1].pic)
                sixOutlet.image = UIImage(named: dices[rand6 - 1].pic)
                if g == record{
                    wins = wins + 1
                    delegate.add(cash: bet * 3)
                    delegate.dAdd(cash: bet * 3)
                    delegate.save()
                    delegate.update()
                    recordLabel.text = "Wins: \(wins) Loses: \(loses)"
                }
                else
                {
                    loses = loses + 1
                    delegate.remove(cash: bet)
                    delegate.dRemove(cash: bet)
                    delegate.save()
                    delegate.update()
                    recordLabel.text = "Wins: \(wins) Loses: \(loses)"
                }
                
            } // end of if let
            else{
                let alert = UIAlertController(title: "Invalid", message: "Invalid Input", preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: "ok", style: .default, handler: nil)
                
                alert.addAction(okAction)
                
                present(alert, animated: true, completion: nil)

            }
            defaults.setValue(wins, forKey: "x")
            defaults.setValue(loses, forKey: "z")
            money = delegate.show()
            moneyOutlet.text = "$\(money)"
            
        }//end of bet check
        else{
            let alert = UIAlertController(title: "Invalid", message: "Can't bet more than you own", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "ok", style: .default, handler: nil)
            
            alert.addAction(okAction)
            
            present(alert, animated: true, completion: nil)

            
            
        }
        
    } // end of func
    
   
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
