//
//  ViewControllerLog.swift
//  final project
//
//  Created by OLIVER MURRAY on 12/11/23.
//

import UIKit

class ViewControllerLog: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var logs = [String]()
    
    var delegate : ViewControllerDelegate!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return logs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell")!
        cell.textLabel?.text = logs[indexPath.row]
        return cell
    }
    
    @IBOutlet weak var tableViewOutlet: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logs = delegate.transfer()
        tableViewOutlet.delegate = self
        tableViewOutlet.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        logs = delegate.transfer()
    }
    

}
