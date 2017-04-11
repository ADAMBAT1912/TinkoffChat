//
//  ConversationsListTableViewController.swift
//  Tinkoff Chat
//
//  Created by adam musallam on 25.03.17.
//  Copyright © 2017 Alphabet. All rights reserved.
//

import UIKit
import Foundation
import MultipeerConnectivity

class ConversationsListTableViewController: UIViewController, UITableViewDataSource,UITableViewDelegate,MPCManagerDelegate{


    @IBAction func showProfileScreen(_ sender: Any) {
        self.dismiss(animated:true,completion:nil)
    }
    
    @IBOutlet var tableView: UITableView!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
   
    var isAdvertising: Bool!
    
         override func viewDidLoad() {
        super.viewDidLoad()
      
            tableView.delegate = self
            tableView.dataSource = self
            
            appDelegate.mpcManager.delegate = self
            
            appDelegate.mpcManager.browser.startBrowsingForPeers()
            
            appDelegate.mpcManager.advertiser.startAdvertisingPeer()
            
            

            
        self.navigationController?.isNavigationBarHidden = false
           self.navigationItem.hidesBackButton = true
        self.title = "Tinkoff Chat"
        isAdvertising = true
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        return 1
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print(appDelegate.mpcManager.foundPeers.count)
           return appDelegate.mpcManager.foundPeers.count
    
    
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    
    

    
   
  
   
    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "conversation", for: indexPath) as! ConversationsTableViewCell
       

        cell.textLabel?.text = appDelegate.mpcManager.foundPeers[indexPath.row].displayName
        print("found")
        
        return cell
    
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        
        
        if let indexPath = tableView.indexPathForSelectedRow{
            let path = indexPath.section
            let detailVC = segue.destination as! MessengerWindow
            detailVC.selectedPath = path
        }
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
       
        
        appDelegate.mpcManager.browser.invitePeer(appDelegate.mpcManager.foundPeers[indexPath.row] as MCPeerID, to: appDelegate.mpcManager.session, withContext: nil, timeout: 20)
    }

    func foundPeer() {
        tableView.reloadData()
    }
    
    
    func lostPeer() {
        tableView.reloadData()
    }
    
    
    
    @IBAction func startStopAdevertising(_ sender: Any) {
        let actionSheet = UIAlertController(title: "", message: "Change Visibility", preferredStyle: UIAlertControllerStyle.alert)
        
        var actionTitle: String
        if isAdvertising == true {
            actionTitle = "Make me invisible to others"
        }
        else{
            actionTitle = "Make me visible to others"
        }
        
        let visibilityAction: UIAlertAction = UIAlertAction(title: actionTitle, style: UIAlertActionStyle.default) { (alertAction) -> Void in
            if self.isAdvertising == true {
                self.appDelegate.mpcManager.advertiser.stopAdvertisingPeer()
            }
            else{
                self.appDelegate.mpcManager.advertiser.startAdvertisingPeer()
                self.foundPeer()
            }
            
            self.isAdvertising = !self.isAdvertising
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) { (alertAction) -> Void in
            
        }
        
        actionSheet.addAction(visibilityAction)
        actionSheet.addAction(cancelAction)
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func invitationWasReceived(fromPeer: String) {
        let alert = UIAlertController(title: "", message: "\(fromPeer) wants to chat with you.", preferredStyle: UIAlertControllerStyle.alert)
        
        let acceptAction: UIAlertAction = UIAlertAction(title: "Accept", style: UIAlertActionStyle.default) { (alertAction) -> Void in
            self.appDelegate.mpcManager.invitationHandler(true, self.appDelegate.mpcManager.session)
            
        }
        
        let declineAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) { (alertAction) -> Void in
            self.appDelegate.mpcManager.invitationHandler(false, nil)
        }
        
        alert.addAction(acceptAction)
        alert.addAction(declineAction)
        
        OperationQueue.main.addOperation { () -> Void in
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func connectedWithPeer(peerID: MCPeerID) {
        OperationQueue.main.addOperation { () -> Void in
            self.performSegue(withIdentifier: "messenger", sender: self)
        }
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


}
