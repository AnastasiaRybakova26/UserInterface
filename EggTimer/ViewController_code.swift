//
//  ViewController_code.swift
//  EggTimer
//
//  Created by Анастасия Рыбакова on 16.08.2023.
//

import UIKit
import AVFoundation

class ViewController_code: UIViewController {
    
    private var player: AVAudioPlayer?
    var timer = Timer()
    
    var totalTime = 0
    var secondsPassed = 0
    let eggTimes = ["Soft" : 5, "Medium" : 8, "Hard" : 12]
    
    
    
    // View в которые будем помещать объекты
        private lazy var topView: UIView = {
            let view = UIView()
//            view.backgroundColor = .systemBlue
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
    
    private lazy var bottomView: UIView = {
        let view = UIView()
//        view.backgroundColor = .systemBlue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // Ветрикальный стэк
    private lazy var verticalStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 40
//        stackView.backgroundColor = .red.withAlphaComponent(0.5)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    // Горизонтальный стэк для картинок яиц
    private lazy var horizontalStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 20
//        stackView.backgroundColor = .green.withAlphaComponent(0.5)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // Вью для яичек
    private lazy var eggViewSoft: UIView = {
        let view = UIView()
//        view.backgroundColor = .systemGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var eggViewMedium: UIView = {
        let view = UIView()
//        view.backgroundColor = .systemGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    private lazy var eggViewHard: UIView = {
        let view = UIView()
//        view.backgroundColor = .systemGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    // Текст и картинки
    private lazy var labelText: UILabel = {
        let label = UILabel()
        label.text = "How do you like your eggs?"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 30)
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var eggImageSoft: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "soft_egg")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var eggImageMedium: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "medium_egg")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var eggImageHard: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "hard_egg")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    private lazy var eggButtonSoft: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(white: 0, alpha: 0)
        button.setTitle("Soft", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var eggButtonMedium: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(white: 0, alpha: 0)
        button.setTitle("Medium", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var eggButtonHard: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(white: 0, alpha: 0)
        button.setTitle("Hard", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        
        return button
    }()
    
    
    private var progressBarView: UIProgressView = {
        let progresView = UIProgressView()
        progresView.progressTintColor = .systemYellow
        progresView.trackTintColor = .systemGray
        progresView.progress = 0.5
        progresView.translatesAutoresizingMaskIntoConstraints = false
        return progresView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        self.setupConstraints()
    }
    
   
    
    
    // Метод при нажатии на кнопку яичка
    @objc
    private func buttonTapped(_ selector: UIButton) {
        self.progressBarView.progress = 0
        let hardness = selector.currentTitle ?? "No data"
        self.secondsPassed = 0
        self.totalTime = self.eggTimes[hardness] ?? 20
        print(hardness, totalTime)
        labelText.text = hardness
        
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1.0,
                             target: self,
                             selector: #selector(updateTimer),
                             userInfo: nil,
                             repeats: true)
    }
    
    @objc
    private func updateTimer() {
        if self.secondsPassed < self.totalTime {
            print("\(self.totalTime - self.secondsPassed) seconds")
            self.secondsPassed += 1
            self.progressBarView.progress = Float(self.secondsPassed) / Float(self.totalTime)
        } else {
            self.timer.invalidate()
            labelText.text = "DONE!"
            self.playSound()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.labelText.text = "How do you like your eggs?"
                self.progressBarView.progress = 0.0
            }
        }
    }
    
    private func playSound() {
        guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else {return}
        self.player = try! AVAudioPlayer(contentsOf: url)
        self.player?.play()
    }
    
}


// MARK: - set views and constraints

extension ViewController_code {
    
    private func setupViews() {
        view.backgroundColor = UIColor(red: 203/255, green: 242/255, blue: 252/255, alpha: 1.0)
        
        view.addSubview(verticalStack)
        verticalStack.addArrangedSubview(topView)
        verticalStack.addArrangedSubview(horizontalStack)
        verticalStack.addArrangedSubview(bottomView)
        
        topView.addSubview(labelText)
        bottomView.addSubview(progressBarView)
        
        horizontalStack.addArrangedSubview(eggViewSoft)
        horizontalStack.addArrangedSubview(eggViewMedium)
        horizontalStack.addArrangedSubview(eggViewHard)
        
        eggViewSoft.addSubview(eggImageSoft)
        eggViewSoft.addSubview(eggButtonSoft)
        
        eggViewMedium.addSubview(eggImageMedium)
        eggViewMedium.addSubview(eggButtonMedium)
        
        eggViewHard.addSubview(eggImageHard)
        eggViewHard.addSubview(eggButtonHard)
    }
    
    
    private func setupConstraints() {
        let constraintsViews: [NSLayoutConstraint] = [
            verticalStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            verticalStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            verticalStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            verticalStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ]
        
        let constraintSubViews: [NSLayoutConstraint] = [
            labelText.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            labelText.leadingAnchor.constraint(equalTo: topView.leadingAnchor),
            labelText.trailingAnchor.constraint(equalTo: topView.trailingAnchor),
            
            self.progressBarView.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor),
            progressBarView.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor),
            progressBarView.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor),
            
            self.eggImageSoft.topAnchor.constraint(equalTo: eggViewSoft.topAnchor),
            eggImageSoft.leadingAnchor.constraint(equalTo: eggViewSoft.leadingAnchor),
            eggImageSoft.trailingAnchor.constraint(equalTo: eggViewSoft.trailingAnchor),
            eggImageSoft.bottomAnchor.constraint(equalTo: eggViewSoft.bottomAnchor),
            
            self.eggButtonSoft.topAnchor.constraint(equalTo: eggViewSoft.topAnchor),
            eggButtonSoft.leadingAnchor.constraint(equalTo: eggViewSoft.leadingAnchor),
            eggButtonSoft.trailingAnchor.constraint(equalTo: eggViewSoft.trailingAnchor),
            eggButtonSoft.bottomAnchor.constraint(equalTo: eggViewSoft.bottomAnchor),
            
            eggImageMedium.topAnchor.constraint(equalTo: eggViewMedium.topAnchor),
            eggImageMedium.leadingAnchor.constraint(equalTo: eggViewMedium.leadingAnchor),
            eggImageMedium.trailingAnchor.constraint(equalTo: eggViewMedium.trailingAnchor),
            eggImageMedium.bottomAnchor.constraint(equalTo: eggViewMedium.bottomAnchor),
            
            self.eggButtonMedium.topAnchor.constraint(equalTo: eggViewMedium.topAnchor),
            eggButtonMedium.leadingAnchor.constraint(equalTo: eggViewMedium.leadingAnchor),
            eggButtonMedium.trailingAnchor.constraint(equalTo: eggViewMedium.trailingAnchor),
            eggButtonMedium.bottomAnchor.constraint(equalTo: eggViewMedium.bottomAnchor),
            
            eggImageHard.topAnchor.constraint(equalTo: eggViewHard.topAnchor),
            eggImageHard.leadingAnchor.constraint(equalTo: eggViewHard.leadingAnchor),
            eggImageHard.trailingAnchor.constraint(equalTo: eggViewHard.trailingAnchor),
            eggImageHard.bottomAnchor.constraint(equalTo: eggViewHard.bottomAnchor),
            
            eggButtonHard.topAnchor.constraint(equalTo: eggViewHard.topAnchor),
            eggButtonHard.leadingAnchor.constraint(equalTo: eggViewHard.leadingAnchor),
            eggButtonHard.trailingAnchor.constraint(equalTo: eggViewHard.trailingAnchor),
            eggButtonHard.bottomAnchor.constraint(equalTo: eggViewHard.bottomAnchor),
        ]
        
        NSLayoutConstraint.activate(constraintsViews)
        NSLayoutConstraint.activate(constraintSubViews)
    }
    
}
