//
//  ViewController.swift
//  MaxApp
//
//  Created by Noah Nethery on 11/17/16.
//  Copyright © 2016 Noah Nethery. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit

class ViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red:0.29, green:0.31, blue:0.34, alpha:1.00)
        view.addSubview(container)
        
        // initializing Facebook login button
        let loginButton: FBSDKLoginButton = FBSDKLoginButton()
        loginButton.delegate = self
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.readPermissions = ["public_profile", "user_friends"]
        loginButton.loginBehavior = .web
        view.addSubview(loginButton)
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.centerYAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        
        setupContainer()
    }
    
    let container: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red:0.88, green:0.88, blue:0.86, alpha:1.00)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red:0.29, green:0.31, blue:0.34, alpha:1.00)
        label.textAlignment = .center
        label.text = "Social\nComposition"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 36)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        
        return label
    }()
    
    let finishedLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red:0.29, green:0.31, blue:0.34, alpha:1.00)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Data processing finished!"
        return label
    }()
    
    let activity: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.color = UIColor(red:0.29, green:0.31, blue:0.34, alpha:1.00)
        
        return view
    }()
    
    func setupContainer() {
        container.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        container.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        container.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40).isActive = true
        container.heightAnchor.constraint(equalTo: view.heightAnchor, constant: -50).isActive = true
        
        container.addSubview(titleLabel)
        container.addSubview(activity)
        activity.isHidden = true
        setupLabel()
        
        container.addSubview(finishedLabel)
        finishedLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        finishedLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        finishedLabel.isHidden = true
    }
    
    func setupLabel() {
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 75).isActive = true
        
        activity.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activity.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        let accessToken = FBSDKAccessToken.current()
        guard let accessTokenString = accessToken?.tokenString else { return }
        
        let credentials = FIRFacebookAuthProvider.credential(withAccessToken: accessTokenString)
        FIRAuth.auth()?.signIn(with: credentials, completion: { (user, error) in
            if error != nil {
                print("Something went wrong with our FB user: ", error ?? "")
                return
            }
            
            print("Successfully logged in with our user: ", user ?? "")
            self.accessProfileData()
        })
        
        
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Logged out")
        self.finishedLabel.isHidden = true
    }
    
    
    // method for accessing data from Facebook's Graph API
    func accessProfileData() {
        activity.startAnimating()
        activity.isHidden = false
        
        if FBSDKAccessToken.current() != nil {
            FBSDKGraphRequest(graphPath: "/me", parameters: ["fields": "first_name, last_name, friends, gender, birthday"]).start { (connection, result, err) in
                
                if err != nil {
                    print("Failed to start graph request:", err ?? "")
                    return
                }
                    
                else {
                    let ref = FIRDatabase.database().reference()
                    let userID = FIRAuth.auth()?.currentUser?.uid
                    
                    // handler for when upload to Firebase is complete
                    ref.child("users").setValue(["\(userID!)": result], withCompletionBlock: { (error, ref) in
                        self.activity.isHidden = true
                        self.activity.stopAnimating()
                        self.finishedLabel.isHidden = false
                    })
                }
            }
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
