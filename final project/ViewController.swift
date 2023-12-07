//
//  ViewController.swift
//  final project
//
//  Created by OLIVER MURRAY on 12/5/23.
//

import UIKit
var money = 0
protocol ViewControllerDelegate{
    
    func add(cash : Int)
    func show() -> Int
    func remove(cash : Int)
}
class ViewController: UIViewController, ViewControllerDelegate {
    
    
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
        add(cash: 1000)
    }

    
    override func viewDidAppear(_ animated: Bool) {
        moneyLabel.text = String(show())
        
        
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "crapsSegue"{
           print("x")
        let nvc = segue.destination as! ViewControllerGame
            nvc.delegate = self
        }
        else if segue.identifier == "warSegue"{
            let nvc = segue.destination as! ViewControllerWar
            nvc.delegate = self
        }
        
    }
    
}

