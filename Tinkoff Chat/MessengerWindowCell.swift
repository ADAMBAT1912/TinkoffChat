//
//  MessengerWindowCell.swift
//  Tinkoff Chat
//
//  Created by adam musallam on 28.03.17.
//  Copyright © 2017 Alphabet. All rights reserved.
//

import UIKit

class MessengerWindowCell: UITableViewCell {

   
    
    @IBOutlet weak var incomeMessage: UILabel!
    @IBOutlet weak var outcomeMessage: UILabel!
    
   
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
