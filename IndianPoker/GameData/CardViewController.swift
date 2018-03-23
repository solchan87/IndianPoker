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
    
    var playerName: String!
    var playerStaus: Bool?
    var card: String?
    
    var guestPlayerName: String?
    var guestPlayerStaus: Bool?
    var guestCard: String?
    
    @IBOutlet var cardNumLb: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        databaseReference = Database.database().reference()
        if playerFlag ==  "guest"{
            databaseReference.child("room-list").child(roomNumber).updateChildValues(["card-status": 1])
        }
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let roomData = databaseReference.child("room-list").child(roomNumber)
        
        let status = roomData.child("card-status")
        
        roomData.child("agree").observe(DataEventType.value) { (snapshot) in
            let num = snapshot.value as! Int
            if num == 2 {
                roomData.updateChildValues(["card-status": 2])
            }
        }
        
        status.observe(DataEventType.value) { (snapshot) in
            let statusNum = snapshot.value as! Int
            
            if statusNum == 1 {
                let addCardAlert = UIAlertController(title: "Are you raedy?", message: "Take your card", preferredStyle: .alert)
                let addAction = UIAlertAction(title: "Get", style: .default) { (action: UIAlertAction) in
                    
                    roomData.child("agree").observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
                        var tempNum = snapshot.value as! Int
                        tempNum += 1
                        roomData.updateChildValues(["agree": tempNum])
                    })
                }
                addCardAlert.addAction(addAction)
                self.show(addCardAlert, sender: nil)
            }else if statusNum == 2 {
                if self.playerFlag ==  "host"{
                    var cardSet = [String: String]()
                    cardSet["host-card"] = "1"
                    cardSet["guest-card"] = "2"
                    
                    roomData.updateChildValues(cardSet)
                    roomData.updateChildValues(["card-status": 3])
                }
            }else if statusNum == 3 {
                roomData.child(self.playerFlag + "-card").observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
                    if let cardNum = snapshot.value as? String{
                        self.cardNumLb.text = cardNum
                    }
                })
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
