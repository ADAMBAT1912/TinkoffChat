//
//  ConversationsListTableViewController.swift
//  Tinkoff Chat
//
//  Created by adam musallam on 25.03.17.
//  Copyright © 2017 Alphabet. All rights reserved.
//

import UIKit
import Foundation

class ConversationsListTableViewController: UIViewController, UITableViewDataSource,UITableViewDelegate{

   
    @IBAction func showProfileScreen(_ sender: Any) {
        self.dismiss(animated:true,completion:nil)
    }
    
    @IBOutlet var tableView: UITableView!
    
    let cell1 = ConversationsTableViewCell()
    let date = Date()
    let calendar = Calendar.current
    
   var sections: [Section] = SectionsData().getSectionsFromData()
    
         override func viewDidLoad() {
        super.viewDidLoad()
      
        self.navigationController?.isNavigationBarHidden = false
           self.navigationItem.hidesBackButton = true
        self.title = "Tinkoff Chat"
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sections.count
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
           return sections[section].items.count
    
    
    }
    
     func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
         return sections[section].heading
    }
    

    
   
    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "conversation", for: indexPath) as! ConversationsTableViewCell
       

        cell.buddyName.text = sections[indexPath.section].items[indexPath.row]
        if sections[indexPath.section].online == false{
            cell.onlineOfflineImage.image = #imageLiteral(resourceName: "OfflineIcon")
            cell.backgroundColor = .white
        }else{
            cell.onlineOfflineImage.image = #imageLiteral(resourceName: "OnlineIcon")
            cell.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 0.7791341146, alpha: 1)
        }
        
        return cell
    
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        
        let vc = segue.destination as! MessengerWindow
        let id =   sender as! Int
        vc.id = id
        if let indexPath = tableView.indexPathForSelectedRow{
            let path = indexPath.section
            let detailVC = segue.destination as! MessengerWindow
            detailVC.selectedPath = path
        }
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "messenger", sender: indexPath.item)
        
        
        
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
