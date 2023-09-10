//
//  ViewController_codeSM.swift
//  EggTimer
//
//  Created by Анастасия Рыбакова on 16.08.2023.
//

import UIKit
import AVFoundation

class ViewController_codeSM : UIViewController {
    
// MARK: - private ptoperties
    private let eggTimes = ["Soft" : 5*60, "Medium" : 8*60, "Hard" : 12*60]
    private var totalTime = 0
    private var secondPassed = 0
    private var timer = Timer()
    private let nameSoundTimer = "alarm_sound"
    private var player: AVAudioPlayer?
    
    
// MARK: - UI
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 30
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
//        stackView.backgroundColor = .systemCyan.withAlphaComponent(0.5)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var eggsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 20
//        stackView.backgroundColor = .green.withAlphaComponent(0.5)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    
    private let eggSoftImage = UIImageView(imageName: "soft_egg")
    private let eggMediumImage = UIImageView(imageName: "medium_egg")
    private let eggHardImage = UIImageView(imageName: "hard_egg")
    
    private let eggSoftButton = UIButton(text: "Soft")
    private let eggMediumButton = UIButton(text: "Medium")
    private let eggHardButton = UIButton(text: "Hard")

    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "How do you like your eggs?"
        label.font = .systemFont(ofSize: 25)
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var timerView: UIView = {
        let view = UIView()
//        view.backgroundColor = .systemBlue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var progressView: UIProgressView = {
        let progresView = UIProgressView()
        progresView.progressTintColor = .systemYellow
        progresView.trackTintColor = .systemGray
        progresView.progress = 0.5
        progresView.translatesAutoresizingMaskIntoConstraints = false
        return progresView
    }()
    
    
    
    
// MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    
    
// MARK: - Busness Logic
    
    @objc private func eggButtonTapped(_ sender: UIButton) {
        let hardness = sender.titleLabel?.text ?? "error"
        titleLabel.text = "You want \(hardness) egg"
        
        totalTime = eggTimes[hardness] ?? 0
        secondPassed = 0
        progressView.setProgress(0, animated: true)
        
        timer.invalidate()  // сборс таймера
        timer = Timer.scheduledTimer(timeInterval: 1.0,
                                     target: self,
                                     selector: #selector(updateTimer),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    @objc private func updateTimer() {
        if secondPassed < totalTime {
            let percentageProgress = Float(secondPassed) / Float(totalTime)
            progressView.setProgress(percentageProgress, animated: true)
            print("\(totalTime - secondPassed) seconds")
            secondPassed += 1
        } else {
//            playSound(nameSoundTimer)
            timer.invalidate()
            secondPassed = 0
            titleLabel.text = "EGG IS DONE!"
            self.progressView.setProgress(1, animated: true)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                self.titleLabel.text = "How do you like your eggs?"
                self.progressView.setProgress(0, animated: true)
            }
        }
    }
    
    private func playSound(_ soundName: String) {
        guard let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") else {return}
        self.player = try! AVAudioPlayer(contentsOf: url)
        self.player?.play()
    }
    
}


// MARK: - set views and constraints

extension ViewController_codeSM {
    
    private func setupViews() {
        view.backgroundColor = UIColor(red: 203/255, green: 242/255, blue: 252/255, alpha: 1.0)
        
        view.addSubview(mainStackView)
        mainStackView.addArrangedSubview(titleLabel)
        mainStackView.addArrangedSubview(eggsStackView)
        mainStackView.addArrangedSubview(timerView)
        
        eggsStackView.addArrangedSubview(eggSoftImage)
        eggsStackView.addArrangedSubview(eggMediumImage)
        eggsStackView.addArrangedSubview(eggHardImage)
        
        eggSoftImage.addSubview(eggSoftButton)
        eggMediumImage.addSubview(eggMediumButton)
        eggHardImage.addSubview(eggHardButton)
        
        eggSoftButton.addTarget(self, action: #selector(eggButtonTapped(_:)), for: .touchUpInside)
        eggMediumButton.addTarget(self, action: #selector(eggButtonTapped(_:)), for: .touchUpInside)
        eggHardButton.addTarget(self, action: #selector(eggButtonTapped(_:)), for: .touchUpInside)
        
        timerView.addSubview(progressView)
    }
    
    private func setupConstraints() {
        let constraints: [NSLayoutConstraint] = [
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            progressView.centerYAnchor.constraint(equalTo: timerView.centerYAnchor),
            progressView.leadingAnchor.constraint(equalTo: timerView.leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: timerView.trailingAnchor),
            
            eggSoftButton.topAnchor.constraint(equalTo: eggSoftImage.topAnchor),
            eggSoftButton.leadingAnchor.constraint(equalTo: eggSoftImage.leadingAnchor),
            eggSoftButton.trailingAnchor.constraint(equalTo: eggSoftImage.trailingAnchor),
            eggSoftButton.bottomAnchor.constraint(equalTo: eggSoftImage.bottomAnchor),
            
            eggMediumButton.topAnchor.constraint(equalTo: eggMediumImage.topAnchor),
            eggMediumButton.leadingAnchor.constraint(equalTo: eggMediumImage.leadingAnchor),
            eggMediumButton.trailingAnchor.constraint(equalTo: eggMediumImage.trailingAnchor),
            eggMediumButton.bottomAnchor.constraint(equalTo: eggMediumImage.bottomAnchor),
            
            eggHardButton.topAnchor.constraint(equalTo: eggHardImage.topAnchor),
            eggHardButton.leadingAnchor.constraint(equalTo: eggHardImage.leadingAnchor),
            eggHardButton.trailingAnchor.constraint(equalTo: eggHardImage.trailingAnchor),
            eggHardButton.bottomAnchor.constraint(equalTo: eggHardImage.bottomAnchor),
            
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}


// MARK: - расширение для кнопки и картинки

extension UIButton {
    convenience init(text: String) {
        self.init(type: .system)
        self.setTitle(text, for: .normal)
        self.titleLabel?.font = .boldSystemFont(ofSize: 20)
        self.tintColor = .white
        self.translatesAutoresizingMaskIntoConstraints = false
        
    }
}


extension UIImageView {
    
    convenience init(imageName: String) {
        self.init()
        self.image = UIImage(named: imageName)
        self.contentMode = .scaleAspectFit
        self.isUserInteractionEnabled = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
}
