//
//  Protocol.swift
//  Tinkoff Chat
//
//  Created by adam musallam on 26.03.17.
//  Copyright © 2017 Alphabet. All rights reserved.
//

import Foundation
class SectionsData {
    
    func getSectionsFromData() -> [Section] {
        
        var sectionsArray = [Section]()
        
        let online = Section(title: "Online", objects: ["Adam", "Vitas", "Kirill", "Sanches","Vasia","Sacha","Icon","Arina","Liza","Cheburek"], line: true)
        let history = Section(title: "History", objects: ["List", "Boats", "Planes", "Motorcycles", "Trucks","LKjl","Lol","Kek","Chechen","Open"], line: false )
        
        
        sectionsArray.append(online)
        sectionsArray.append(history)
        
        
        return sectionsArray
    }
}

class MessageData {
    
    func getMessageFromData() -> [Messege]{
        
        var messegeArray = [Messege]()
        var letter = Messege(text:[""])
        
        messegeArray.append(letter)
        
        return messegeArray
    }
}
