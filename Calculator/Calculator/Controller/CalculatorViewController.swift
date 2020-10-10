//
//  CalculatorViewController.swift
//  Calculator
//
//  Created by SHIN YOON AH on 2020/09/02.
//  Copyright © 2020 SHIN YOON AH. All rights reserved.
//

import UIKit
import SnapKit

class CalculatorViewController: UIViewController {
    private let displayLabel = UILabel()
    private let savedDataButton = UIButton()
    private let restoredDataButton = UIButton()
    private let addButton = UIButton()
    private let subtractButton = UIButton()
    private let divideButton = UIButton()
    private let multiplyButton = UIButton()
    private let faiButton = UIButton()
    private let eButton = UIButton()
    private let rootButton = UIButton()
    private let cosineButton = UIButton()
    private let pointButton = UIButton()
    private let equalsButton = UIButton()
    private var numberButtons: [UIButton] = []
    
    private var IsTypingBetween = false
    private var calculatorModel = CalculatorModel()
    private var saveProgramData: CalculatorModel.propertyList?
    
    private var displayTextValue: Double {
        get {
            if let displayedText = Double(displayLabel.text ?? "0.0") {
                return displayedText
            } else {
                return 0.0
            }
        }
        set {
            displayLabel.text = String(newValue)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeNumberButton()
        
        configureSetUp()
        
        stackViewSetUp()
        
        positionSetUp()
    }
    
    private func makeNumberButton() {
        for index in 0...9 {
            let numberButton = UIButton()
            
            view.addSubview(numberButton)
            settingButton(numberButton, title: String(index))
            numberButtons.append(numberButton)
        }
    }
    
    private func configureSetUp() {
        view.backgroundColor = .black
        
        view.addSubview(savedDataButton)
        view.addSubview(restoredDataButton)
        view.addSubview(displayLabel)
        view.addSubview(addButton)
        view.addSubview(subtractButton)
        view.addSubview(multiplyButton)
        view.addSubview(divideButton)
        view.addSubview(faiButton)
        view.addSubview(eButton)
        view.addSubview(rootButton)
        view.addSubview(cosineButton)
        view.addSubview(pointButton)
        view.addSubview(equalsButton)
        
        displayLabel.text = "0"
        displayLabel.font = UIFont.systemFont(ofSize: 60)
        displayLabel.textColor = .white
        displayLabel.textAlignment = .right
        displayLabel.numberOfLines = 2
        
        settingButton(savedDataButton, title: "Save")
        settingButton(restoredDataButton, title: "Restore")
        settingButton(addButton, title: "+")
        settingButton(subtractButton, title: "-")
        settingButton(multiplyButton, title: "×")
        settingButton(divideButton, title: "÷")
        settingButton(faiButton, title: "π")
        settingButton(eButton, title: "e")
        settingButton(rootButton, title: "√")
        settingButton(cosineButton, title: "cos")
        settingButton(pointButton, title: ".")
        settingButton(equalsButton, title: "=")
    }
    
    private func stackViewSetUp(){
        let fourOperatorStackView = UIStackView()
        view.addSubview(fourOperatorStackView)
        fourOperatorStackView.distribution = .fillEqually
        fourOperatorStackView.axis = .horizontal
        fourOperatorStackView.spacing = 15
        fourOperatorStackView.addArrangedSubview(addButton)
        fourOperatorStackView.addArrangedSubview(subtractButton)
        fourOperatorStackView.addArrangedSubview(multiplyButton)
        fourOperatorStackView.addArrangedSubview(divideButton)
        
        let firstDigitStackView = UIStackView()
        view.addSubview(firstDigitStackView)
        firstDigitStackView.distribution = .fillEqually
        firstDigitStackView.axis = .horizontal
        firstDigitStackView.spacing = 15
        firstDigitStackView.addArrangedSubview(faiButton)
        firstDigitStackView.addArrangedSubview(numberButtons[7])
        firstDigitStackView.addArrangedSubview(numberButtons[8])
        firstDigitStackView.addArrangedSubview(numberButtons[9])
        
        let secondDigitStackView = UIStackView()
        view.addSubview(secondDigitStackView)
        secondDigitStackView.distribution = .fillEqually
        secondDigitStackView.axis = .horizontal
        secondDigitStackView.spacing = 15
        secondDigitStackView.addArrangedSubview(eButton)
        secondDigitStackView.addArrangedSubview(numberButtons[4])
        secondDigitStackView.addArrangedSubview(numberButtons[5])
        secondDigitStackView.addArrangedSubview(numberButtons[6])
        
        let thirdDigitStackView = UIStackView()
        view.addSubview(thirdDigitStackView)
        thirdDigitStackView.distribution = .fillEqually
        thirdDigitStackView.axis = .horizontal
        thirdDigitStackView.spacing = 15
        thirdDigitStackView.addArrangedSubview(rootButton)
        thirdDigitStackView.addArrangedSubview(numberButtons[1])
        thirdDigitStackView.addArrangedSubview(numberButtons[2])
        thirdDigitStackView.addArrangedSubview(numberButtons[3])
        
        let fourthDigitStackView = UIStackView()
        view.addSubview(fourthDigitStackView)
        fourthDigitStackView.distribution = .fillEqually
        fourthDigitStackView.axis = .horizontal
        fourthDigitStackView.spacing = 15
        fourthDigitStackView.addArrangedSubview(cosineButton)
        fourthDigitStackView.addArrangedSubview(pointButton)
        fourthDigitStackView.addArrangedSubview(numberButtons[0])
        fourthDigitStackView.addArrangedSubview(equalsButton)
        
        let containStackView = UIStackView()
        view.addSubview(containStackView)
        containStackView.axis = .vertical
        containStackView.spacing = 25
        containStackView.addArrangedSubview(fourOperatorStackView)
        containStackView.addArrangedSubview(firstDigitStackView)
        containStackView.addArrangedSubview(secondDigitStackView)
        containStackView.addArrangedSubview(thirdDigitStackView)
        containStackView.addArrangedSubview(fourthDigitStackView)
        containStackView.snp.makeConstraints{ make in
            make.top.equalTo(displayLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(100)
        }
    }
    
    private func positionSetUp() {
        savedDataButton.snp.makeConstraints{ make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.trailing.equalToSuperview().inset(20)
        }
        
        restoredDataButton.snp.makeConstraints{ make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.trailing.equalTo(savedDataButton.snp.leading).offset(-20)
        }
        
        displayLabel.snp.makeConstraints{ make in
            make.top.equalTo(savedDataButton.snp.bottom).offset(50)
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    private func settingButton(_ sender: UIButton, title: String){
        sender.setTitle(title, for: .normal)
        sender.setTitleColor(.white, for: .normal)
        sender.layer.cornerRadius = 20
        sender.layer.masksToBounds = true
        
        switch title {
        case "+", "-", "×", "÷":
            sender.titleLabel?.font = UIFont.systemFont(ofSize: 30)
            sender.backgroundColor = .systemYellow
            sender.addTarget(self, action: #selector(performOperation(_:)), for: .touchUpInside)
        case "π", "e", "√", "cos":
            sender.titleLabel?.font = UIFont.systemFont(ofSize: 30)
            sender.backgroundColor = .darkGray
            sender.addTarget(self, action: #selector(performOperation(_:)), for: .touchUpInside)
        case "0"..."9":
            sender.titleLabel?.font = UIFont.systemFont(ofSize: 30)
            sender.backgroundColor = .lightGray
            sender.addTarget(self, action: #selector(didTouchDigit(_:)), for: .touchUpInside)
        case ".", "=":
            sender.titleLabel?.font = UIFont.systemFont(ofSize: 30)
            sender.backgroundColor = .lightGray
            sender.addTarget(self, action: #selector(performOperation(_:)), for: .touchUpInside)
        case "Save":
            sender.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            sender.addTarget(self, action: #selector(didSavedData), for: .touchUpInside)
            sender.layer.masksToBounds = false
        case "Restore":
            sender.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            sender.addTarget(self, action: #selector(didRestoredData), for: .touchUpInside)
            sender.layer.masksToBounds = false
        default:
            print("There is no button.")
        }
    }
    
    @objc private func didTouchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle
        
        if IsTypingBetween {
            let displayedText = displayLabel.text
            
            if let replacedDigit = digit, let replacedText = displayedText {
                displayLabel.text = replacedText + replacedDigit
            }
        } else {
            displayLabel.text = digit ?? " "
        }
        
        IsTypingBetween = true
    }
    
    @objc private func performOperation(_ sender: UIButton) {
        if IsTypingBetween {
            calculatorModel.setOperand(operand: displayTextValue)
            IsTypingBetween = false
        }
        
        if let mathmaticalSymbol = sender.currentTitle {
            calculatorModel.performOperation(symbol: mathmaticalSymbol)
        }
        displayTextValue = calculatorModel.result
    }
    
    @objc private func didSavedData() {
        saveProgramData = calculatorModel.program
    }
    
    @objc private func didRestoredData(){
        if let programData = saveProgramData {
            calculatorModel.program = programData
            displayTextValue = calculatorModel.result
        }
    }
}
