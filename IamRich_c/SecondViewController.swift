//
//  SecondViewController.swift
//  IamRich
//
//  Created by Анастасия Рыбакова on 15.04.2023.
//

import UIKit

class SecondViewController: UIViewController {
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.text = "I am Rich, but don,t ask me money"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont(name: "Helvetica", size: 40)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var coalImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "coal")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapImage(_:)))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tap)
        
        return imageView
    }()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    private func setupView() {
        self.view.backgroundColor = .systemMint
        
        self.view.addSubview(self.textLabel)
        self.view.addSubview(self.coalImage)
        
        let constraints: [NSLayoutConstraint] = [
            self.coalImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.coalImage.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.coalImage.heightAnchor.constraint(equalToConstant: 270),
            self.coalImage.widthAnchor.constraint(equalToConstant: 270),
            
            self.textLabel.bottomAnchor.constraint(equalTo: self.coalImage.topAnchor, constant: -70),
            self.textLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.textLabel.widthAnchor.constraint(equalToConstant: self.view.frame.size.width - 100)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc
    private func didTapImage(_ sender: UITapGestureRecognizer) {
        print("dismiss")
        self.dismiss(animated: true)
        
    }
    
}
