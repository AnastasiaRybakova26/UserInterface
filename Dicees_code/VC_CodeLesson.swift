//
//  VC_CodeLesson.swift
//  Dicees_code
//
//  Created by Анастасия Рыбакова on 08.08.2023.
//

import Foundation
import UIKit

class VC_CodeLesson: UIViewController {
    
    private let diceesNameArray: [String] = ["DiceOne", "DiceTwo", "DiceThree", "DiceFour", "DiceFive", "DiceSix"]
    
    private lazy var backGroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "GreenBackground")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var logoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "DiceeLogo")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var diceOneImage: UIImageView = {
        let imageView = UIImageView()
//        imageView.image = UIImage(named: "DiceOne")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var diceTwoImage: UIImageView = {
        let imageView = UIImageView()
//        imageView.image = UIImage(named: "DiceTwo")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var rollButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("ROLL", for: .normal)
        button.titleLabel?.font = UIFont(name: "Arial", size: 30)
//        button.setTitleColor(.white, for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor(red: 155/255, green: 28/255, blue: 31/255, alpha: 1.0)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(rollButtonTapped(_:)), for: .touchUpInside)
        
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupConstraints()
    }
    
    private func setupView() {
        view.addSubview(backGroundImage)
        view.addSubview(logoImage)
        view.addSubview(diceOneImage)
        view.addSubview(diceTwoImage)
        view.addSubview(rollButton)
        
        setDiceImage()
    }
    
    
    private func setupConstraints() {
        let constraints: [NSLayoutConstraint] = [
            backGroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backGroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backGroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backGroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            logoImage.widthAnchor.constraint(equalToConstant: 200),
            logoImage.heightAnchor.constraint(equalToConstant: 130),
            logoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            diceOneImage.widthAnchor.constraint(equalToConstant: 100),
            diceOneImage.heightAnchor.constraint(equalToConstant: 100),
            diceOneImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            diceOneImage.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -40),
            
            diceTwoImage.widthAnchor.constraint(equalToConstant: 100),
            diceTwoImage.heightAnchor.constraint(equalToConstant: 100),
            diceTwoImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            diceTwoImage.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 40),
            
            rollButton.widthAnchor.constraint(equalToConstant: 150),
            rollButton.heightAnchor.constraint(equalToConstant: 60),
            rollButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            rollButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -120),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    
    @objc
    private func rollButtonTapped(_ sender: UIButton) {
        setDiceImage()
    }
    
    private func setDiceImage() {
        diceOneImage.image = UIImage(named: diceesNameArray.randomElement() ?? diceesNameArray[0])
        diceTwoImage.image = UIImage(named: diceesNameArray.randomElement() ?? diceesNameArray[0])
    }
    
}

