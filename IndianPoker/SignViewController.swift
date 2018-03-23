//
//  SignViewController.swift
//  IndianPoker
//
//  Created by 배지호 on 2018. 3. 23..
//  Copyright © 2018년 SolChan Ahn. All rights reserved.
//

import UIKit
import Firebase

class SignViewController: UIViewController {
    
    
    @IBOutlet weak var idEmailTF: UITextField!
    @IBOutlet weak var signPwTF: UITextField!
    @IBOutlet weak var realNameTF: UITextField!
    @IBOutlet weak var nickName: UITextField!
    
    var coin: Int = 100
    
    @IBAction func sign(_ sender: Any) {
        
        Auth.auth().createUser(withEmail: idEmailTF.text!, password: signPwTF.text!) { (user, error) in
            if user == nil {
                let alert = UIAlertController(title: "확인", message: "회원가입하시겠습니까?", preferredStyle: .alert)
                let action1 = UIAlertAction(title: "네", style: .default, handler: { (action) in
                    databaseReference = Database.database().reference()
                    
                    let userID = Auth.auth().currentUser!.uid
                    let usersRef = databaseReference.child("user-info").child(userID)
                    
                    let post = ["uid": userID,
                                "name": self.realNameTF.text!,
                                "nick-name": self.nickName.text!,
                                "coin": self.coin] as [String : Any]
                    usersRef.updateChildValues(post)
                    self.navigationController?.popViewController(animated: true)
                })
                alert.addAction(action1)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func back(_ sender: Any) {
        let alert = UIAlertController(title: "확인", message: "뒤로가시겠습니까?", preferredStyle: .alert)
        let action1 = UIAlertAction(title: "네", style: .default) { (action) in
            self.navigationController?.popViewController(animated: true)
        }
        let action2 = UIAlertAction(title: "아니요", style: .cancel, handler: nil)
        alert.addAction(action1)
        alert.addAction(action2)
        self.present(alert, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        idEmailTF.delegate = self
        signPwTF.delegate = self
        realNameTF.delegate = self
        nickName.delegate = self
    }
}

extension SignViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if idEmailTF.text == "" {
            idEmailTF.becomeFirstResponder()
        } else if idEmailTF.text != "" {
            idEmailTF.resignFirstResponder()
            signPwTF.becomeFirstResponder()
        } else if signPwTF.text != "" {
            signPwTF.resignFirstResponder()
            realNameTF.becomeFirstResponder()
        } else if realNameTF.text != "" {
            realNameTF.resignFirstResponder()
            nickName.becomeFirstResponder()
        } else {
            nickName.resignFirstResponder()
        }
        return true
    }
}
