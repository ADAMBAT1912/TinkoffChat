//
//  ConversationsTableViewCell.swift
//  Tinkoff Chat
//
//  Created by adam musallam on 26.03.17.
//  Copyright © 2017 Alphabet. All rights reserved.
//

import UIKit

class ConversationsTableViewCell: UITableViewCell{

    @IBOutlet weak var buddyName: UILabel!
    
        @IBOutlet weak var dateOfLastMessage: UILabel!
    
    @IBOutlet weak var lastMessage: UILabel!
    
   
    
   
    @IBOutlet weak var onlineOfflineImage: UIImageView!
    
    

    
    override func awakeFromNib() {
    super.awakeFromNib()
     
        
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


