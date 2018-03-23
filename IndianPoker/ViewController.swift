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
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var pwTF: UITextField!
    @IBOutlet weak var signUp: UIButton!
    @IBOutlet weak var nextViewb: UIButton!
    
    
    let gradient = CAGradientLayer()
    var gradientSet = [[CGColor]]()
    var currentGradient: Int = 0
    
    let gradientOne = UIColor(red: 48/255, green: 62/255, blue: 103/255, alpha: 1).cgColor
    let gradientTwo = UIColor(red: 30/255, green: 88/255, blue: 53/255, alpha: 1).cgColor
    let gradientThree = UIColor(red: 200/255, green: 70/255, blue: 107/255, alpha: 1).cgColor
    
    @IBAction func signUpAction(_ sender: Any) {
        let alert1 = UIAlertController(title: "확인", message: "가입하시겠습니까?", preferredStyle: .alert)
        let action1 = UIAlertAction(title: "네", style: .default) { (action) in
            let sign = self.navigationController?.storyboard?.instantiateViewController(withIdentifier: "SignViewController")
            self.navigationController?.pushViewController(sign!, animated: true)
        }
        let action2 = UIAlertAction(title: "아니요", style: .cancel, handler: nil)
        alert1.addAction(action1)
        alert1.addAction(action2)
        self.present(alert1, animated: true, completion: nil)
    }
    
    @IBAction func nextViewBtn(_ sender: UIButton) {
        Auth.auth().signIn(withEmail: emailTF.text!, password: pwTF.text!) { (user, error) in
            if user != nil {
                let newVC = self.navigationController?.storyboard?.instantiateViewController(withIdentifier: "nextViewController")
                self.navigationController?.pushViewController(newVC!, animated: true)
            } else {
                let alert = UIAlertController(title: "확인", message: "틀렸습니다.", preferredStyle: .alert)
                let action1 = UIAlertAction(title: "네", style: .cancel, handler: nil)
                alert.addAction(action1)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        data()
        if let user = Auth.auth().currentUser {
            let alert = UIAlertController(title: "확인", message: "이미 로그인 된 상태입니다.", preferredStyle: .alert)
            let action1 = UIAlertAction(title: "네", style: .default, handler: nil)
            alert.addAction(action1)
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        gradientSet.append([gradientOne, gradientTwo])
        gradientSet.append([gradientTwo, gradientThree])
        gradientSet.append([gradientThree, gradientOne])
        
        gradient.frame = self.view.bounds
        gradient.colors = gradientSet[currentGradient]
        gradient.startPoint = CGPoint(x:0, y:0)
        gradient.endPoint = CGPoint(x:1, y:1)
        gradient.drawsAsynchronously = true
        self.view.layer.addSublayer(gradient)
        
        self.view.addSubview(emailTF)
        self.view.addSubview(pwTF)
        self.view.addSubview(nextViewb)
        self.view.addSubview(signUp)
        
        emailTF.delegate = self
        pwTF.delegate = self

        animateGradient()
    }
    
    func animateGradient() {
        if currentGradient < gradientSet.count - 1 {
            currentGradient += 1
        } else {
            currentGradient = 0
        }
        
        let gradientChangeAnimation = CABasicAnimation(keyPath: "colors")
        gradientChangeAnimation.duration = 8
        gradientChangeAnimation.repeatCount = 3
        gradientChangeAnimation.toValue = gradientSet[currentGradient]
        gradientChangeAnimation.fillMode = kCAFillModeForwards
        gradientChangeAnimation.isRemovedOnCompletion = false
        gradient.add(gradientChangeAnimation, forKey: "colorChange")
    }
    
    func data() {
        databaseReference = Database.database().reference()
        
        let testDB = databaseReference.child("test").child("1")
        testDB.observe(DataEventType.value) { (snapshot) in
            let value = snapshot.value as? String
            
            print(value!)
        }
    }
}

extension ViewController: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            gradient.colors = gradientSet[currentGradient]
            animateGradient()
        }
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if emailTF.text == "" {
            emailTF.becomeFirstResponder()
        } else {
            emailTF.resignFirstResponder()
            pwTF.becomeFirstResponder()
        }
        return true
    }
}

