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
        
        // you could replace the contents of this function with an HTTP GET, a database fetch request,
        // or anything you like, as long as you return an array of Sections this program will
        // function the same way.
        
        var sectionsArray = [Section]()
        let userCalendar = NSCalendar.current
        let timeComponent = NSDateComponents()
        let online = Section(title: "Online", objects: ["Adam", "Vitas", "Kirill", "Sanches","Vasia","Sacha","Icon","Arina","Liza","Cheburek"], line: true)
        let history = Section(title: "History", objects: ["List", "Boats", "Planes", "Motorcycles", "Trucks","LKjl","Lol","Kek","Chechen","Open"], line: false )
        
        
        sectionsArray.append(online)
        sectionsArray.append(history)
        
        
        return sectionsArray
    }
}
