//
//  CardViewController.swift
//  IndianPoker
//
//  Created by SolChan Ahn on 2018. 3. 24..
//  Copyright © 2018년 SolChan Ahn. All rights reserved.
//

import UIKit
import Firebase

class CardViewController: UIViewController {
    
    var roomNumber:String!
    
    var playerFlag:String!
    
    var hostPlayerName: String!
    var hostPlayerStaus: Bool?
    var hostCard: String?
    
    var guestPlayerName: String!
    var guestPlayerStaus: Bool?
    var guestCard: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        databaseReference = Database.database().reference()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
