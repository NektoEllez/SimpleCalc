//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Иван Марин on 08.09.2022.
//

import UIKit

class ViewController: UIViewController {
    // MARK: — Views
    private let display = UITextField()
    private let displayView = UIView()
    private let mainVStack = UIStackView()
    // MARK: — Properties
    var service: CalcService?
    let targetHeight = CGFloat(25)
    // MARK: — ViewController Life Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        service = CalcService(displayView: self)
        view.backgroundColor = .lightGray
        
        configureAppearance()
    }
    // MARK: — ViewController Methods
    func updateDisplay(text: String) {
        DispatchQueue.main.async { [weak self] in
            self?.display.text = text
        }
    }
    
    @objc func buttonPressed(_ sender: UIButton) {
        switch sender.tag {
        case 0...9: service?.numberAction(number: sender.tag)
        case 10: service?.dot()
        case 11: service?.makeResult()
        case 12: service?.addition()
        case 13: service?.subtraction()
        case 14: service?.multiplication()
        case 15: service?.acAction()
        case 16: service?.changeSign()
        case 17: service?.percent()
        case 18: service?.division()
        default: break
        }
    }
}

// MARK: — View Controller Private Methods
private extension ViewController {
    
    func configureAppearance() {
        setupMainVStack()
        setupDisplayView()
        setupButtons()
    }
    
    func setupMainVStack() {
        mainVStack.axis = .vertical
        mainVStack.frame = CGRect(
            x: 0, y: 60,
            width: Constants.screenWidth,
            height: Constants.screenHeight - 60
        )
        mainVStack.backgroundColor = .lightGray
        
        self.view.addSubview(mainVStack)
    }
    
    func setupDisplayView() {
        displayView.frame = CGRect(
            x: 0, y: -2,
            width: Constants.screenWidth,
            height: Constants.screenHeight - (82 * 5.5) - 90
        )
        displayView.backgroundColor = .lightGray
        
        display.frame = CGRect(
            x: 15, y: 15,
            width: displayView.frame.width - 30,
            height: displayView.frame.height - 15
        )
        display.textAlignment = .right
        display.contentVerticalAlignment = .bottom
        display.text = "0"
        display.textColor = .white
        display.font = UIFont.boldSystemFont(ofSize: 80)
        display.backgroundColor = .gray
        
        displayView.addSubview(display)
        mainVStack.addSubview(displayView)
    }
    
    func setupButtons() {
        setupLineOne()
        setupLineTwo()
        setupLineThree()
        setupLineFour()
        setupLineFive()
    }

    func setupLineOne () {
        let lineOne = createHStack(
            yPosition: Int(displayView.frame.height) + 0
        )
        
        let acButton = createButton(order: 0, title: "AC", tag: 15)
        acButton.addTarget(
            self, action: #selector(buttonPressed(_:)), for: .touchUpInside
        )
        
        
        let changeSignButton = createButton(order: 1, title: "+/-", tag: 16)
        changeSignButton.addTarget(
            self, action: #selector(buttonPressed(_:)), for: .touchUpInside
        )
        let percentButton = createButton(order: 2, title: "%", tag: 17)
        percentButton.addTarget(
            self, action: #selector(buttonPressed(_:)), for: .touchUpInside
        )
        let divideButton = createButton(order: 3, title: "/", tag: 18)
        divideButton.addTarget(
            self, action: #selector(buttonPressed(_:)), for: .touchUpInside
        )
        
        lineOne.addSubview(acButton)
        lineOne.addSubview(changeSignButton)
        lineOne.addSubview(percentButton)
        lineOne.addSubview(divideButton)
        
        mainVStack.addSubview(lineOne)
    }
    
    func setupLineTwo () {
        let lineTwo = createHStack(
            yPosition: Int(displayView.frame.height) + 80 + 2
        )
        let sevenButton = createButton(order: 0, title: "7", tag: 7)
        sevenButton.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        let eightButton = createButton(order: 1, title: "8", tag: 8)
        eightButton.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        let nineButton = createButton(order: 2, title: "9", tag: 9)
        nineButton.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        let multiplyButton = createButton(order: 3, title: "*", tag: 14)
        multiplyButton.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        
        lineTwo.addSubview(sevenButton)
        lineTwo.addSubview(eightButton)
        lineTwo.addSubview(nineButton)
        lineTwo.addSubview(multiplyButton)
        
        mainVStack.addSubview(lineTwo)
        
    }
    
    func setupLineThree () {
        let lineThree = createHStack(
            yPosition: Int(displayView.frame.height) + (80*2) + 4
        )
        let fourButton = createButton(order: 0, title: "4", tag: 4)
        fourButton.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        let fiveButton = createButton(order: 1, title: "5", tag: 5)
        fiveButton.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        let sixButton = createButton(order: 2, title: "6", tag: 6)
        sixButton.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        let subsButton = createButton(order: 3, title: "—", tag: 13)
        subsButton.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        
        lineThree.addSubview(fourButton)
        lineThree.addSubview(fiveButton)
        lineThree.addSubview(sixButton)
        lineThree.addSubview(subsButton)
        
        mainVStack.addSubview(lineThree)
    }
    
    func setupLineFour () {
        let lineFour = createHStack(
            yPosition: Int(displayView.frame.height) + (80*3) + 6
        )
        let oneButton = createButton(order: 0, title: "1", tag: 1)
        oneButton.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        let twoButton = createButton(order: 1, title: "2", tag: 2)
        twoButton.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        let threeButton = createButton(order: 2, title: "3", tag: 3)
        threeButton.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        let plusButton = createButton(order: 3, title: "+", tag: 12)
        plusButton.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        
        lineFour.addSubview(oneButton)
        lineFour.addSubview(twoButton)
        lineFour.addSubview(threeButton)
        lineFour.addSubview(plusButton)
        
        mainVStack.addSubview(lineFour)
    }
    
    func setupLineFive () {
        let lineFive = createHStack(
            yPosition:  Int(displayView.frame.height) + (80*4) + 8
        )
        
        let zeroButton = (createButton(order: 0, title: "0", tag: 0))
        zeroButton.frame = CGRect(
            x: 2, y: 0,
            width: (Int(Constants.screenWidth) / 4) * 2 - 2,
            height: 80
        )
        zeroButton.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        
        let dotButton = createButton(order: 2, title: ".", tag: 10)
        dotButton.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        
        let equalButton = createButton(order: 3, title: "=", tag: 11)
        equalButton.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        
        lineFive.addSubview(zeroButton)
        lineFive.addSubview(dotButton)
        lineFive.addSubview(equalButton)
        mainVStack.addSubview(lineFive)
    }
    
    func createButton(
        order: Int,
        title: String,
        tag: Int
    ) -> UIButton {
        let button = UIButton(
            frame: CGRect(
                x: (0 + Int(Constants.screenWidth / 4) * order + 2),
                y: 0,
                width: Int(Constants.screenWidth) / 4 - 2,
                height: 80
            )
        )
        
        button.setTitle(title, for: .normal)
        button.backgroundColor = .darkGray
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        button.setTitleColor(.white, for: .normal)
        button.tag = tag
        return button
    }
    func createButtonWithImage(
        order: Int,
        image: UIImage,
        tag: Int
    ) -> UIButton {
        let button = UIButton(
            frame: CGRect(
                x: (0 + Int(Constants.screenWidth / 4) * order + 2),
                y: 0,
                width: Int(Constants.screenWidth) / 4 - 2,
                height: 80
            )
        )
        
        button.setTitle(title, for: .normal)
        button.backgroundColor = .darkGray
        button.setTitleColor(.white, for: .normal)
        button.tag = tag
        return button
    }
    
//    func butImage(name: String) -> UIImage {
//        guard let image = UIImage(named: name) else { fatalError() }
//        image.
//        return  image
//    }
    
    func createHStack(yPosition: Int) -> UIStackView {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.frame = CGRect(
            x: -1, y: yPosition,
            width: Int(Constants.screenWidth), height: 80
        )
        return stack
    }
}


// MARK: Canvas as in SWIFTUI
///In order not to constantly load the device simulator
///you can enable Canvas and watch the changes in the UI in real time
#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct ViewController_Representable:
    UIViewControllerRepresentable
{
    func makeUIViewController(
        context: Context
    ) -> some UIViewController
    {
        return ViewController()
    }
    
    func updateUIViewController(
        _ uiViewController: UIViewControllerType,
        context: Context
    ) { }
    
}

struct ViewController_Preview:
    PreviewProvider
{
    static var previews:
    some View
    {
        ViewController_Representable()
            .previewLayout(.sizeThatFits)
            .previewDevice("Iphone 13 Pro")
    }
}
#endif
