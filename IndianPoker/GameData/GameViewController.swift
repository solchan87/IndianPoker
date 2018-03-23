//
//  GameViewController.swift
//  IndianPoker
//
//  Created by SolChan Ahn on 2018. 3. 23..
//  Copyright © 2018년 SolChan Ahn. All rights reserved.
//

import UIKit
import Firebase

class GameViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var roomListTable: UITableView!
    
    let tempPlayerName = "solchan"
    
    var roomToLoad = [AnyObject]()

    override func viewDidLoad() {
        super.viewDidLoad()
        databaseReference = Database.database().reference()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let roomListData = databaseReference.child("room-list")
        roomListData.observe(DataEventType.value) { (snapshot) in
            self.roomToLoad.removeAll()
            
            let enumrator = snapshot.children
            while let roomItem = enumrator.nextObject() as? DataSnapshot{
                let room = roomItem.value as AnyObject
                
                self.roomToLoad.append(room)
            }
            self.roomListTable.reloadData()
        }
    }
    
    @IBAction func addRoomBtn(_ sender: Any) {

        let addRoomAlert = UIAlertController(title: "Add New Room", message: "Enter New Room Name", preferredStyle: .alert)
        addRoomAlert.addTextField()
        let addA = UIAlertAction(title: "ADD", style: .default) { (action: UIAlertAction) in
            if let roomName = addRoomAlert.textFields?[0].text {
                
                let currentTimeMilliseconds = Date().timeIntervalSince1970
                let milliseconds = Int(currentTimeMilliseconds * 1000)
                
                let roomdata = databaseReference.child("room-list")
                var roomItem = [String: Any]()
                roomItem["room-name"] = roomName
                roomItem["room-status"] = true
                roomItem["room-player"] = self.tempPlayerName
                roomItem["room-number"] = String(milliseconds)
                
                roomdata.child(String(milliseconds)).setValue(roomItem)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        addRoomAlert.addAction(addA)
        addRoomAlert.addAction(cancelAction)
        self.show(addRoomAlert, sender: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var roomCount = 0
        
        if roomToLoad.count > 0 {
            roomCount = roomToLoad.count
        }
        
        return roomCount
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let roomCell: RoomViewCell = tableView.dequeueReusableCell(withIdentifier: "roomCell") as! RoomViewCell
        
        let roomItem = self.roomToLoad[indexPath.row] as! NSDictionary
        
        roomCell.roomNameLb.text = roomItem.value(forKey: "room-name") as? String
        roomCell.playerNameLb.text = roomItem.value(forKey: "room-player") as? String
        roomCell.roomNumber = roomItem.value(forKey: "room-number") as? String
        roomCell.roomFlag = roomItem.value(forKey: "room-status") as? Bool
        
        return roomCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        let selectedCell = tableView.cellForRowAtIndexPath(indexPath)
//        print(selectedCell?.textLabel?.text)
//        // this will print Optional("Bike") if indexPath.row == 0
//    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell: RoomViewCell = tableView.cellForRow(at: indexPath) as! RoomViewCell
        print(selectedCell.roomNumber)
    }

}
