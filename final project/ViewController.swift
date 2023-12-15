//
//  ViewController.swift
//  final project
//
//  Created by OLIVER MURRAY on 12/5/23.
//

import UIKit
let defaults = UserDefaults.standard
var money = 1000
var dMoney = 0
var logins = 0
var curLog = 0
var log : String = ""
var logs = [String]()
var timesRan = 0

protocol ViewControllerDelegate{
    func save()
    func viewLog() -> Int
    func login(log : Int)
    func add(cash : Int)
    func show() -> Int
    func remove(cash : Int)
    func dAdd(cash : Int)
    func dRemove(cash : Int)
    func update()
    func transfer() -> [String]
    
}
class ViewController: UIViewController, ViewControllerDelegate {
    func transfer() -> [String] {
        return logs
    }
    
    func update() {
        
        if timesRan == 0{
            logs.append("Login: \(logins) Net Gain: $\(dMoney)")
            timesRan = 1
        }
        else{
        logs[logins - 1] = "Login: \(logins) Net Gain: $\(dMoney)"
        }
        defaults.setValue(logs, forKey: "listP")
        
    }//end of update function
    
    
    
    
    
    func save() {
        defaults.setValue(money, forKey: "mP")
    }
    
    func viewLog() -> Int {
        return curLog
    }
    
    func login(log: Int) {
        logins = logins + log
        
    }
    
    func dRemove(cash: Int) {
        dMoney = dMoney - cash
    }
    
    func dAdd(cash: Int) {
        dMoney = dMoney + cash
    }
    
   
    
    
    
    @IBOutlet weak var moneyLabel: UILabel!
    
    
    func remove(cash: Int) {
        money = money - cash
    }
    
    func add(cash: Int) {
        money = money + cash
    }
    
    func show() -> Int {
        return money
    }
    
    
    
   
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
        
       // money = defaults.integer(forKey: "m")
        
        
        if let l = defaults.object(forKey: "listP"){
            logs = l as! [String]
        }
        
        logins = defaults.integer(forKey: "cP")
        login(log: 1)
        defaults.setValue(logins, forKey: "cP")
    
        money = defaults.integer(forKey: "mP")
        
        if logins <= 1{
        money = 1000
        }
       
        update()
        
    }

    
    override func viewDidAppear(_ animated: Bool) {
    
        let x = show()
        moneyLabel.text = "$\(x)"
        
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
        if segue.identifier == "crapsSegue"{
           
        let nvc = segue.destination as! ViewControllerGame
            nvc.delegate = self
        }
        else if segue.identifier == "warSegue"{
            let nvc = segue.destination as! ViewControllerWar
            nvc.delegate = self
        }
        else if segue.identifier == "logSegue"{
            let nvc = segue.destination as! ViewControllerLog
            nvc.delegate = self
            
            
        }
        else if segue.identifier == "guessSegue"{
            let nvc = segue.destination as! ViewControllerG
            nvc.delegate = self
            
            
            
        }
        
        
    }
    
}

