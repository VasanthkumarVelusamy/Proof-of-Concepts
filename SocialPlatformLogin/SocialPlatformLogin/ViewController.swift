//
//  ViewController.swift
//  SocialPlatformLogin
//
//  Created by Vasanthkumar V on 11/06/17.
//  Copyright © 2017 Vasanthkumar V. All rights reserved.
//

import UIKit
import FBSDKLoginKit
class ViewController: UIViewController, FBSDKLoginButtonDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        let fbLoginButton = FBSDKLoginButton()
        fbLoginButton.frame = CGRect(x: 50, y: 50, width: view.frame.width - 100, height: 50)
        view.addSubview(fbLoginButton)
        fbLoginButton.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Logged out of facebook")
    }

    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print("Error found \(error.localizedDescription)")
            return
        }
        print("successfully logged in with facebook")
    }

}

