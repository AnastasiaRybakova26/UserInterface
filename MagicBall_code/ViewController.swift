
//  ViewController.swift
//  MagicBall_code
//
//  Created by Анастасия Рыбакова on 17.04.2023.
//

import UIKit

class ViewController: UIViewController {

    private let ballsArray = ["ball1", "ball2", "ball3", "ball4", "ball5"]
    
// Элементы интерфейса
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.text = "Ask me anything..."
        label.textColor = .white
        label.font = UIFont(name: "Helvetica", size: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()


    private lazy var ballImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ballsArray.randomElement() ?? ballsArray[0])
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var askButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitleColor(.systemMint, for: .normal)
        button.setTitle("ASK", for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 30)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button .addTarget(self, action: #selector(askButtontapped(_:)), for: .touchUpInside)
        
        return button
    }()
    
    
    // Горизонтальная ориентация эерана
// Горизонтальный стэк для шара и пары текст+кнопка (они будут в вертикальном стэке)
    private lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = CGFloat(30)
//        stackView.backgroundColor = .systemOrange.withAlphaComponent(0.7)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    
// Вертикальный стэк для текст + кнопка (они будут справа)
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = CGFloat(100)
//        stackView.backgroundColor = .black.withAlphaComponent(0.5)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
// Вью, которые поместим в горизонтальный стэк
    private lazy var leftView: UIView = {
        let view = UIView()
//        view.backgroundColor = .systemBlue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var rightView: UIView = {
        let view = UIView()
//        view.backgroundColor = .systemBlue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
// Массивы сабвью для настройки представления
    private lazy var subViewsForPortrait: [UIView] = [
        self.textLabel,
        self.ballImage,
        self.askButton,
    ]
    
    private lazy var allSubViews: [UIView] = [
        self.textLabel,
        self.askButton,
        self.verticalStackView,
        self.rightView,
        self.ballImage,
        self.leftView,
        self.horizontalStackView,
    ]
    
    
    
    private lazy var constraintPortpait: [NSLayoutConstraint] = [
        self.ballImage.widthAnchor.constraint(equalToConstant: 200),
        self.ballImage.heightAnchor.constraint(equalToConstant: 200),
        self.ballImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
        self.ballImage.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
        
        self.textLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
        self.textLabel.bottomAnchor.constraint(equalTo: self.ballImage.topAnchor, constant: -100),
        
        self.askButton.widthAnchor.constraint(equalToConstant: 150),
        self.askButton.heightAnchor.constraint(equalToConstant: 50),
        self.askButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
        self.askButton.topAnchor.constraint(equalTo: self.ballImage.bottomAnchor, constant: 100),
    ]
    
    
    private lazy var constraintLandscape: [NSLayoutConstraint] = [
        
        horizontalStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        horizontalStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        horizontalStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
        horizontalStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        
        ballImage.widthAnchor.constraint(equalToConstant: 200),
        ballImage.heightAnchor.constraint(equalToConstant: 200),
        ballImage.centerXAnchor.constraint(equalTo: leftView.centerXAnchor),
        ballImage.centerYAnchor.constraint(equalTo: leftView.centerYAnchor),
        
        verticalStackView.centerYAnchor.constraint(equalTo: rightView.centerYAnchor),
        verticalStackView.centerXAnchor.constraint(equalTo: rightView.centerXAnchor),
    ]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .systemMint
        self.setupSubViews()
        self.setupConstraints()
    }
    
    
// Метод,который вызывается при повороте экрана
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        self.setupSubViews()
        self.setupConstraints()
    }
    
    
    
    private func setupSubViews() {
// При первом запуске удаляем все элементы с экрана, не важно, портретная ориентация или альбомная, тк экран собираем заново
        allSubViews.forEach { $0.removeFromSuperview() }
        
    
// Если ориентация портретная, то помещаем три элемента вью в супервью
// Если ориентация ландшафтная, то справа горизонтальный стэк, а слева вертикальный стэк

        if UIDevice.current.orientation.isLandscape {
            view.backgroundColor = .systemPurple
            
            // Добавляем сабвью в альбомном представлении
            view.addSubview(horizontalStackView)
            
            horizontalStackView.addArrangedSubview(leftView)
            horizontalStackView.addArrangedSubview(rightView)
            
            leftView.addSubview(ballImage)
            rightView.addSubview(verticalStackView)
            
            verticalStackView.addArrangedSubview(textLabel)
            verticalStackView.addArrangedSubview(askButton)
            
        } else {
            view.backgroundColor = .systemMint
            // Добавляем сабвью в портретном представлении
            subViewsForPortrait.forEach { view.addSubview($0) }
        }
    }
    
    
// Настройка констрейнтов
    private func setupConstraints() {
        
        if UIDevice.current.orientation.isLandscape {
            print("Landscape")
            NSLayoutConstraint.deactivate(constraintPortpait)
            NSLayoutConstraint.activate(constraintLandscape)
        } else {
            print("Portrait")
            NSLayoutConstraint.deactivate(constraintLandscape)
            NSLayoutConstraint.activate(constraintPortpait)
        }
    }
    
    
// Обработка нажатия кнопки askButton
    @objc
    private func askButtontapped(_ sender: UIButton) {
        self.ballImage.image = UIImage(named: self.ballsArray.randomElement() ?? self.ballsArray[0])
    }


}





