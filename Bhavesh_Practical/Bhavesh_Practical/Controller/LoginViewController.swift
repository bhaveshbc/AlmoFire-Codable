//
//  LoginViewController.swift
//  Bhavesh_Practical
//
//  Created by Bhavesh Chaudhari on 03/05/19.
//  Copyright © 2019 Bhavesh Chaudhari. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet var emailTextField : UITextField!
    @IBOutlet var paswordTextField : UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func loginClick(sender:UIButton) {
          let paramter = ["Username":emailTextField.text!,"Password":paswordTextField.text!]
        customeClient.userLogin(parameter:paramter) { (loginResponse) in
            (UIApplication.shared.delegate as! AppDelegate).UserInfo = loginResponse
            let FeedsController =  ViewController.instantiate(fromAppStoryboard: .Main)
            DispatchQueue.main.async {
                    self.navigationController?.pushViewController(FeedsController, animated: true)
            }
        }
    }
}
