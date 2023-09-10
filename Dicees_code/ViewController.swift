//
//  ViewController.swift
//  Dicees_code
//
//  Created by Анастасия Рыбакова on 15.04.2023.
//

import UIKit

class ViewController: UIViewController {

    private let diceesNameArray: [String] = ["DiceOne", "DiceTwo", "DiceThree", "DiceFour", "DiceFive", "DiceSix"]
    
    
    private lazy var backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "GreenBackground")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var diceLeftImage: UIImageView = {
        let imageView = UIImageView()
//        imageView.image = UIImage(named: "DiceOne")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var diceRightImage: UIImageView = {
        let imageView = UIImageView()
//        imageView.image = UIImage(named: "DiceTwo")
        imageView.contentMode = .scaleAspectFit
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
    
    private lazy var rollBotton: UIButton = {
        let button = UIButton()
        button.setTitle("ROLL", for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 40)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor(red: 0.5547, green: 0.16, blue: 0.1445, alpha: 1.0)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(rollButtonTapped(_:)), for: .touchUpInside)
        
        return button
    }()
    
    
// View в которые будем помещать объекты
    private lazy var topView: UIView = {
        let view = UIView()
//        view.backgroundColor = .systemBlue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var middleView: UIView = {
        let view = UIView()
//        view.backgroundColor = .systemYellow
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var bottomView: UIView = {
        let view = UIView()
//        view.backgroundColor = .systemGreen
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
   
    
// Вертикальный стэк
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
//        stackView.distribution = .fillEqually
        stackView.distribution = .fillProportionally
        stackView.spacing = CGFloat(10)
//        stackView.backgroundColor = .red.withAlphaComponent(0.5)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
// Горизонтальный стэк для костей
    private lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = CGFloat(50)
//        stackView.backgroundColor = .systemOrange.withAlphaComponent(0.7)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setDicees()
        self.setupView()
    }
    
    
// Portrait and landscape orientation with stackView
    private func setupView() {
        
        self.view.addSubview(self.backgroundImage)
        self.view.addSubview(self.verticalStackView)
        
        self.verticalStackView.addArrangedSubview(self.topView)
        self.verticalStackView.addArrangedSubview(self.middleView)
        self.verticalStackView.addArrangedSubview(self.bottomView)

        self.topView.addSubview(self.logoImage)
        self.bottomView.addSubview(self.rollBotton)
        self.middleView.addSubview(self.horizontalStackView)
        
        self.horizontalStackView.addArrangedSubview(self.diceLeftImage)
        self.horizontalStackView.addArrangedSubview(self.diceRightImage)
        
        let constraints: [NSLayoutConstraint] = [
            self.backgroundImage.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.backgroundImage.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.backgroundImage.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.backgroundImage.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            
            self.verticalStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.verticalStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.verticalStackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.verticalStackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            
            self.logoImage.widthAnchor.constraint(equalToConstant: 200),
            self.logoImage.heightAnchor.constraint(equalToConstant: 100),
            self.logoImage.centerXAnchor.constraint(equalTo: self.topView.centerXAnchor),
            self.logoImage.centerYAnchor.constraint(equalTo: self.topView.centerYAnchor),
            
            self.rollBotton.widthAnchor.constraint(equalToConstant: 150),
            self.rollBotton.heightAnchor.constraint(equalToConstant: 60),
            self.rollBotton.centerXAnchor.constraint(equalTo: self.bottomView.centerXAnchor),
            self.rollBotton.centerYAnchor.constraint(equalTo: self.bottomView.centerYAnchor),
            
            // Настраиваем центральное вью с костями
            self.horizontalStackView.centerYAnchor.constraint(equalTo: self.middleView.centerYAnchor),
            self.horizontalStackView.centerXAnchor.constraint(equalTo: self.middleView.centerXAnchor),
            self.diceLeftImage.widthAnchor.constraint(equalToConstant: 100),
            self.diceLeftImage.heightAnchor.constraint(equalToConstant: 100),
            self.diceRightImage.widthAnchor.constraint(equalToConstant: 100),
            self.diceRightImage.heightAnchor.constraint(equalToConstant: 100),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }


    
    @objc
    private func rollButtonTapped(_ selector: UIButton) {
        self.setDicees()
    }
    
    private func setDicees() {
        self.diceLeftImage.image = UIImage(named: self.diceesNameArray.randomElement() ?? self.diceesNameArray[0])
        self.diceRightImage.image = UIImage(named: self.diceesNameArray.randomElement() ?? self.diceesNameArray[0])
    }
    
}

