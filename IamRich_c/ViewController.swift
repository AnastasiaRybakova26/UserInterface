//
//  ViewController.swift
//  IamRich
//
//  Created by Анастасия Рыбакова on 15.04.2023.
//

import UIKit

class ViewController: UIViewController {

    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.text = "I am Rich"
        label.textColor = .white
        label.font = UIFont(name: "Helvetica", size: 50)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var dimondImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "diamond")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var checkButton: UIButton = {
        let button = UIButton()
        button.setTitle("CHECK", for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 30)
        button.layer.cornerRadius = 10
        button.backgroundColor = .white
        button.setTitleColor(UIColor(red: 0.14, green: 0.285, blue: 0.3672, alpha: 1.0), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self,
                         action: #selector(didTapButton(_:)),
                         for: .touchUpInside)
        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }

    
    
    private func setupView() {
        self.view.backgroundColor = UIColor(red: 0.14, green: 0.285, blue: 0.3672, alpha: 1.0)  // Нужно RGB раздедить на 255
        
        self.view.addSubview(self.textLabel)
        self.view.addSubview(self.dimondImage)
        self.view.addSubview(self.checkButton)
        
        let constraints: [NSLayoutConstraint] = [
            self.dimondImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.dimondImage.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.dimondImage.heightAnchor.constraint(equalToConstant: 270),
            self.dimondImage.widthAnchor.constraint(equalToConstant: 270),
            
            self.textLabel.bottomAnchor.constraint(equalTo: self.dimondImage.topAnchor, constant: -70),
            self.textLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            self.checkButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.checkButton.topAnchor.constraint(equalTo: self.dimondImage.bottomAnchor, constant: 70),
            self.checkButton.widthAnchor.constraint(equalToConstant: 200)
            
        ]
        
        NSLayoutConstraint.activate(constraints)
    }

    @objc
    private func didTapButton(_ sender: UIButton) {
        print("button is tapped")
        self.present(SecondViewController(), animated: true)
    }
}

