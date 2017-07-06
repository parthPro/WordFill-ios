//
//  HomeScreenViewController.swift
//  textViewTappedWord
//
//  Created by parth on 7/3/17.
//  Copyright © 2017 parthanand.com. All rights reserved.
//

import UIKit

class HomeScreenVC: UIViewController {

    let backgroundImage: UIImageView = {
        
        let background = UIImageView(image: #imageLiteral(resourceName: "white"))
        background.translatesAutoresizingMaskIntoConstraints = false
        background.contentMode = .scaleAspectFill
        return background
        
    }()
    
    let logoLabel: UILabel = {
    
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "WordFill"
        label.textAlignment = .center
        label.font = UIFont(name: "Georgia", size: 70)
        label.textColor = UIColor(red: 63/255, green: 81/255, blue: 181/255, alpha: 0.9)
        return label
        
    }()
    
    let divider1: UIView = {
    
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.lightGray
        return view
    }()
    
    let divider2: UIView = {
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.lightGray
        return view
    }()
    
    let easyButton: UIButton = {
    
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Easy", for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir", size: 20)
        button.setTitleColor(.darkGray, for: .normal)
        return button
    }()
    
    let mediumButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Medium", for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir", size: 20)
        button.setTitleColor(.darkGray, for: .normal)

        return button
    }()
    
    let hardButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Hard", for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir", size: 20)
        button.setTitleColor(.darkGray, for: .normal)
        
        return button
    }()
    


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        easyButton.addTarget(self, action: #selector(handleEasy), for: .touchUpInside)
        mediumButton.addTarget(self, action: #selector(handleMedium), for: .touchUpInside)
        hardButton.addTarget(self, action: #selector(handleHard), for: .touchUpInside)


        view.addSubview(backgroundImage)
        view.addSubview(divider1)
        view.addSubview(logoLabel)
        view.addSubview(easyButton)
        view.addSubview(mediumButton)
        view.addSubview(divider2)
        view.addSubview(hardButton)

        backgroundImage.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImage.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        backgroundImage.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        divider1.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        divider1.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        divider1.widthAnchor.constraint(equalToConstant: view.frame.width/2).isActive = true
        divider1.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        logoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -view.frame.height/4).isActive = true
        logoLabel.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        logoLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        easyButton.bottomAnchor.constraint(equalTo: divider1.topAnchor).isActive = true
        easyButton.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        easyButton.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        easyButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        mediumButton.topAnchor.constraint(equalTo: divider1.bottomAnchor).isActive = true
        mediumButton.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        mediumButton.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        mediumButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        divider2.topAnchor.constraint(equalTo: mediumButton.bottomAnchor).isActive = true
        divider2.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        divider2.widthAnchor.constraint(equalToConstant: view.frame.width/2).isActive = true
        divider2.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        hardButton.topAnchor.constraint(equalTo: divider2.bottomAnchor).isActive = true
        hardButton.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        hardButton.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        hardButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        

    }
    
    func handleEasy(){
        
       

        
        ViewController.level = "easy"
        present(UINavigationController(rootViewController: ViewController()), animated: true, completion: nil)
        
    }
    
    func handleMedium(){
    
        ViewController.level = "medium"
        present(UINavigationController(rootViewController: ViewController()), animated: true, completion: nil)

    }
    
    func handleHard(){
    
        ViewController.level = "hard"
        present(UINavigationController(rootViewController: ViewController()), animated: true, completion: nil)

    }



}
