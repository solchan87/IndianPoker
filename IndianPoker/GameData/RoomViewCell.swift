//
//  RoomViewCell.swift
//  IndianPoker
//
//  Created by SolChan Ahn on 2018. 3. 24..
//  Copyright © 2018년 SolChan Ahn. All rights reserved.
//

import UIKit

class RoomViewCell: UITableViewCell {
    
    @IBOutlet var roomNameLb: UILabel!
    @IBOutlet var playerNameLb: UILabel!
    @IBOutlet var roomStatusLb: UILabel!
    
    var roomNumber: String!
    
    var roomFlag: Bool!{
        willSet{
            if newValue == true{
                self.backgroundColor = UIColor.white
                roomStatusLb.text = "1 / 2"
            }else{
                self.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
                roomStatusLb.text = "2 / 2"
                self.isUserInteractionEnabled = false
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
