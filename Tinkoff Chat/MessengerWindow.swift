//
//  MessengerWindow.swift
//  Tinkoff Chat
//
//  Created by adam musallam on 27.03.17.
//  Copyright © 2017 Alphabet. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class MessengerWindow: UIViewController,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate{

    @IBOutlet weak var enterMessage: UITextField!
    
    required init?(coder aDecoder: NSCoder) {
        id = 0
        selectedPath = 0
        super.init(coder: aDecoder)
    }
    

    var messagesArray: [Dictionary<String, String>] = []
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var id:Int 
    var selectedPath: Int
    var message:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.estimatedRowHeight = 60.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        enterMessage.delegate = self
 
        NotificationCenter.default.addObserver(self, selector: Selector(("endLostChat")), name: NSNotification.Name(rawValue: "receivedLostChatNotification"), object: nil)
        NotificationCenter.default.removeObserver(self)
        /*NotificationCenter.default.addObserver(self, selector: Selector(StringLiteralType("handleMPCReceivedDataWithNotification:")), name: NSNotification.Name(rawValue: "receivedMPCDataNotification"), object: nil)
        */
        self.title = appDelegate.mpcManager.foundPeers[selectedPath].displayName
        // Do any additional setup after loading the view, typically from a nib.
       
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messagesArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "in") as! MessengerWindowCell
       
        let currentMessage = messagesArray[indexPath.row] as Dictionary<String, String>
        

        
        if let sender = currentMessage["sender"] {
            var senderLabelText: String
            var senderColor: UIColor
            
            
            if sender == "self"{
                senderLabelText = "I said:"
                senderColor = UIColor.purple
            }
            else{
                senderLabelText = sender + " said:"
                senderColor = UIColor.orange
            }
            
            cell.outcomeMessage.text = senderLabelText
            cell.outcomeMessage.textColor = senderColor
        }
        
        if let message = currentMessage["message"] {
            cell.incomeMessage.text = message
        }
        
        return cell
    }

        
    @IBAction func sendMessage(_ sender: Any)  {
      
        
            
        let messageDictionary: [String: String] = ["message": enterMessage.text!]
        
        if appDelegate.mpcManager.sendData(dictionaryWithData: messageDictionary, toPeer: appDelegate.mpcManager.session.connectedPeers[0]){
            
            let dictionary: [String: String] = ["sender": "self", "message": enterMessage.text!]
            messagesArray.append(dictionary)
            
            self.updateTableview()
        }
        else{
            print("Could not send data")
        }
        
        }
        
    func updateTableview(){
        tableView.reloadData()
        
        if self.tableView.contentSize.height > self.tableView.frame.size.height {
            tableView.scrollToRow(at: IndexPath(item: messagesArray.count - 1, section: 0), at: UITableViewScrollPosition.bottom, animated: true)
        }
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func handleMPCReceivedDataWithNotification(notification: NSNotification) {
        let receivedDataDictionary = notification.object as! Dictionary<String, AnyObject>
        
        // "Extract" the data and the source peer from the received dictionary.
        let data = receivedDataDictionary["data"] as? NSData
        let fromPeer = receivedDataDictionary["fromPeer"] as! MCPeerID
        
        // Convert the data (NSData) into a Dictionary object.
        let dataDictionary = NSKeyedUnarchiver.unarchiveObject(with: data! as Data) as! Dictionary<String, String>
        
        // Check if there's an entry with the "message" key.
        if let message = dataDictionary["message"] {
            // Make sure that the message is other than "_end_chat_".
            if message != "_end_chat_"{
                // Create a new dictionary and set the sender and the received message to it.
                let messageDictionary: [String: String] = ["sender": fromPeer.displayName, "message": message]
                
                // Add this dictionary to the messagesArray array.
                messagesArray.append(messageDictionary)
                
                // Reload the tableview data and scroll to the bottom using the main thread.
                OperationQueue.main.addOperation({ () -> Void in
                    self.updateTableview()
                })
            }
            else{
                // In this case an "_end_chat_" message was received.
                // Show an alert view to the user.
                let alert = UIAlertController(title: "", message: "\(fromPeer.displayName) ended this chat.", preferredStyle: UIAlertControllerStyle.alert)
                
                let doneAction: UIAlertAction = UIAlertAction(title: "Okay", style: UIAlertActionStyle.default) { (alertAction) -> Void in
                    self.appDelegate.mpcManager.session.disconnect()
                    self.dismiss(animated: true, completion: nil)
                }
                
                alert.addAction(doneAction)
                
                OperationQueue.main.addOperation({ () -> Void in
                    self.present(alert, animated: true, completion: nil)
                })
                
            }
        }
    }

    @IBAction func endChat(_ sender: Any) {
        let messageDictionary: [String: String] = ["message": "_end_chat_"]
        if appDelegate.mpcManager.sendData(dictionaryWithData: messageDictionary, toPeer: appDelegate.mpcManager.session.connectedPeers[0] as MCPeerID){
            self.dismiss(animated: true, completion: { () -> Void in
                self.appDelegate.mpcManager.session.disconnect()
            })
        }
    }
   
    
}

