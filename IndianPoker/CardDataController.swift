//
//  CardDataController.swift
//  IndianPoker
//
//  Created by SolChan Ahn on 2018. 3. 23..
//  Copyright © 2018년 SolChan Ahn. All rights reserved.
//

import Foundation

class CardDataController {
    
    let cardList = [1,2,3,4,5,6,7,8,9,10,1,2,3,4,5,6,7,8,9,10]
    
    func shuffleCardList() -> [Int] {
        var tempList = cardList
        var resultList: [Int] = []
        
        while tempList.count != 0{
            let index: Int = Int(arc4random_uniform(UInt32(tempList.count)))
            resultList.append(tempList[index])
            tempList.remove(at: index)
        }
        return resultList
    }
    
    
}
