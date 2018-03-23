//
//  ViewController.swift
//  IndianPoker
//
//  Created by SolChan Ahn on 2018. 3. 23..
//  Copyright © 2018년 SolChan Ahn. All rights reserved.
//

import UIKit
import Firebase

var databaseReference: DatabaseReference!

class ViewController: UIViewController {
    var cardDataController: CardDataController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        databaseReference = Database.database().reference()
        
        let testDB = databaseReference.child("test").child("1")
        testDB.observe(DataEventType.value) { (snapshot) in
            let value = snapshot.value as? String
            
            print(value)
        }
        
         card
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

