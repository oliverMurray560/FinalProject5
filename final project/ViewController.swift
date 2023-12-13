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
protocol ViewControllerDelegate{
    func viewLog() -> Int
    func login(log : Int)
    func add(cash : Int)
    func show() -> Int
    func remove(cash : Int)
    func dAdd(cash : Int)
    func dRemove(cash : Int)
}
class ViewController: UIViewController, ViewControllerDelegate {
    func viewLog() -> Int {
        return curLog
    }
    
    func login(log: Int) {
        logins = logins + log
        //print(login)
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
       // add(cash: 1000)
        
        logins = defaults.integer(forKey: "c")
        login(log: 1)
        defaults.setValue(logins, forKey: "c")
        
    }

    
    override func viewDidAppear(_ animated: Bool) {
        //moneyLabel.text = String(show())
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
        
    }
    
}

