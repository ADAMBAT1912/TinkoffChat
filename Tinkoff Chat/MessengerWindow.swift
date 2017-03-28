//
//  MessengerWindow.swift
//  Tinkoff Chat
//
//  Created by adam musallam on 27.03.17.
//  Copyright © 2017 Alphabet. All rights reserved.
//

import UIKit

class MessengerWindow: UIViewController,UITableViewDataSource,UITableViewDelegate{

    @IBOutlet weak var enterMessage: UITextField!
    
    required init?(coder aDecoder: NSCoder) {
        id = 0
        selectedPath = 0
        super.init(coder: aDecoder)
    }
    
    var sections: [Section] = SectionsData().getSectionsFromData()
    var messeges: [Messege] = MessageData().getMessageFromData()
    
    @IBOutlet weak var tableView: UITableView!
    
    var id:Int 
    var selectedPath: Int
    var message:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        
        self.title = sections[selectedPath].items[id]
        // Do any additional setup after loading the view, typically from a nib.
       
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messeges[section].type.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellOut = tableView.dequeueReusableCell(withIdentifier: "out") as! MessengerWindowCell
        cellOut.outcomeMessage.text = messeges[indexPath.section].type[indexPath.row]
        return cellOut
            }
        
    @IBAction func sendMessage(_ sender: Any)  {
        let cellOut = tableView.dequeueReusableCell(withIdentifier: "out") as! MessengerWindowCell
        if enterMessage.text != nil{
            
            messeges[0].type.append(enterMessage.text!)
            enterMessage.text = nil
            cellOut.outcomeMessage.text = messeges[0].type[1]
        }
        
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
