//
//  ViewController.swift
//  MaxApp
//
//  Created by Noah Nethery on 11/17/16.
//  Copyright © 2016 Noah Nethery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
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
        label.text = "Demo"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 36)
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red:0.29, green:0.31, blue:0.34, alpha:1.00)
        view.addSubview(container)
        setupContainer()
    }
    
    func setupContainer() {
        container.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        container.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        container.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40).isActive = true
        container.heightAnchor.constraint(equalTo: view.heightAnchor, constant: -40).isActive = true
        
        container.addSubview(titleLabel)
        setupLabel()
    }
    
    func setupLabel() {
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        //titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 75).isActive = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

