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
        print(sender)
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
        
        lineOne.addSubview(acButton)
        lineOne.addSubview(changeSignButton)
        
        lineOne.addSubview(createButton(order: 2, title: "%", tag: 17))
        lineOne.addSubview(createButton(order: 3, title: "/", tag: 18))
        mainVStack.addSubview(lineOne)
    }
    func setupLineTwo () {
        let lineTwo = createHStack(
            yPosition: Int(displayView.frame.height) + 80 + 2
        )
        
        lineTwo.addSubview(createButton(order: 0, title: "0", tag: 4))
        lineTwo.addSubview(createButton(order: 1, title: "1", tag: 5))
        lineTwo.addSubview(createButton(order: 2, title: "2", tag: 6))
        lineTwo.addSubview(createButton(order: 3, title: "3", tag: 7))
        mainVStack.addSubview(lineTwo)
        
    }
    func setupLineThree () {
        let lineThree = createHStack(
            yPosition: Int(displayView.frame.height) + (80*2) + 4
        )
        
        lineThree.addSubview(createButton(order: 0, title: "8", tag: 8))
        lineThree.addSubview(createButton(order: 1, title: "9", tag: 9))
        lineThree.addSubview(createButton(order: 2, title: "10", tag: 10))
        lineThree.addSubview(createButton(order: 3, title: "11", tag: 11))
        mainVStack.addSubview(lineThree)
    }
    func setupLineFour () {
        let lineFour = createHStack(
            yPosition: Int(displayView.frame.height) + (80*3) + 6
        )
        
        lineFour.addSubview(createButton(order: 0, title: "12", tag: 12))
        lineFour.addSubview(createButton(order: 1, title: "13", tag: 13))
        lineFour.addSubview(createButton(order: 2, title: "14", tag: 14))
        lineFour.addSubview(createButton(order: 3, title: "15", tag: 15))
        mainVStack.addSubview(lineFour)
    }
    func setupLineFive () {
        let lineFive = createHStack(
            yPosition:  Int(displayView.frame.height) + (80*4) + 8
        )
        
        let zeroButton = (createButton(order: 0, title: "16", tag: 16))
        zeroButton.frame = CGRect(
            x: 2, y: 0,
            width: (Int(Constants.screenWidth) / 4) * 2 - 2,
            height: 80
        )
        lineFive.addSubview(zeroButton)
    
        lineFive.addSubview(createButton(order: 2, title: "18", tag: 18))
        lineFive.addSubview(createButton(order: 3, title: "19", tag: 19))
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
