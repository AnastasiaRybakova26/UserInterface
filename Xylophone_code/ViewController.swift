//
//  ViewController.swift
//  Xylophone_code
//
//  Created by Анастасия Рыбакова on 09.08.2023.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    private var player: AVAudioPlayer?
    
    private let nameButtons = ["C", "D", "E", "F", "G", "A", "B"]

    private var buttonStackView: UIStackView = {
        let stackView = UIStackView()
//        stackView.backgroundColor = .systemGreen.withAlphaComponent(0.5)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = CGFloat(10)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupConstraints()
        self.createButtons()
    }
    
    // Метод создает несколько кнопок
    private func createButtons() {
        for (index, nameButton) in nameButtons.enumerated() {
            let multiplierWidth = 0.97 - 0.025 * Double(index)
            self.createButton(name: nameButton, widthMultiplier: multiplierWidth)
        }
    }
    
    
    // Метод создает кнопку и помещает ее в вертикальный стэкВью
    private func createButton(name: String, widthMultiplier: Double) {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setTitleColor(.white, for: .normal)
//        button.titleLabel?.font = UIFont(name: "Helvetica", size: 40)
        button.titleLabel?.font = .systemFont(ofSize: 40)
        button.setTitle(name, for: .normal)
        button.layer.cornerRadius = 10
        
        // Устанавливаем цвет кнопки в зависимости от ее названия
        button.backgroundColor = self.getColor(for: name)
        
        // При нажатии на кнопку сработает метод buttonTapped
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        
        buttonStackView.addArrangedSubview(button)
        button.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: widthMultiplier).isActive = true
    }
    
    // Определяем цвет клавиши в зависимости от названия кнопки
    private func getColor(for name: String) -> UIColor {
        switch name {
        case "C": return .systemRed
        case "D": return .systemOrange
        case "E": return .systemYellow
        case "F": return .systemGreen
        case "G": return .systemIndigo
        case "A": return .systemBlue
        case "B": return .systemPurple
        default: return .systemGray
        }
    }
    
    // Метод, срабатывает при нажатии на кнопку: проигрывается музыка + менятся прозрачность
    @objc
    private func buttonTapped(_ sender: UIButton) {
        self.togleButtonAlfa(sender)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.togleButtonAlfa(sender)
        }
        
        guard let buttonText = sender.currentTitle else {return}
        playSound(buttonText)
    }
    
    // Меняем прозрачность: если она была = 1, то делаем 0.5 (иначе 1)
    private func togleButtonAlfa(_ sender: UIButton) {
        sender.alpha = sender.alpha == 1 ? 0.5 : 1
    }
    
    // Проигрываем музыку
    private func playSound(_ buttonText: String) {
        guard let url = Bundle.main.url(forResource: buttonText, withExtension: "wav") else {return}
        player = try! AVAudioPlayer(contentsOf: url)
        player?.play()
    }
    
}


// Методы можно реализовывать в расширении
extension ViewController {
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(buttonStackView)
    }

    private func setupConstraints() {
        
        let constraints: [NSLayoutConstraint] = [
            buttonStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            buttonStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            buttonStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            buttonStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}

