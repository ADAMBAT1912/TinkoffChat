//
//  SectionModel.swift
//  Tinkoff Chat
//
//  Created by adam musallam on 27.03.17.
//  Copyright © 2017 Alphabet. All rights reserved.
//

import Foundation
struct Section {
    
    var heading : String
    var items : [String]
    var online : Bool
    
    init(title: String, objects : [String], line: Bool) {
        
        heading = title
        items = objects
        online = line
        
    }
}

struct Messege {
    
    var type: [String]
    
    init(text:[String]){
        
        type = text
        
    }
}
