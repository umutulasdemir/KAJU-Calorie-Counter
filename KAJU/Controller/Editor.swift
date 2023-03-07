//
//  Editor.swift
//  KAJU
//
//  Created by kadir on 2.03.2023.
//

import UIKit

class Editor: UIViewController {
    
    let backGroundColor = ThemesOptions.backGroundColor
    let cellBackgColor = ThemesOptions.cellBackgColor
    var eyeButton: UIButton?
    var textLabel: UILabel!
    var textValue: UILabel!
    let blurEffect: UIBlurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
    var blurEffectView: UIVisualEffectView!
    
    let contentView = {
        let view = UIView()
        let width = CGFloat(275)
        let height = CGFloat(200)
        view.anchor(width: width, height: height)
        view.backgroundColor = ThemesOptions.cellBackgColor.withAlphaComponent(0.6)
        view.layer.cornerRadius = 10
        return view
    }()
    let titleLabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 28)
        return label
    }()
    let textField = {
        let textField = UITextField()
        let height = CGFloat(40)
        textField.anchor(height: height)
        textField.borderStyle = .roundedRect
        textField.textColor = .systemGray
        textField.contentMode = .scaleAspectFill
        return textField
    }()
    let doneButton = {
        let button = UIButton()
        let width = CGFloat(76)
        let height = CGFloat(40)
        button.anchor(width: width, height: height)
        button.setTitle("Done", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)

        button.backgroundColor = ThemesOptions.buttonBackGColor
        button.layer.cornerRadius = 20
        return button
    }()
    let cancelButton = {
        let button = UIButton()
        let width = CGFloat(88)
        let height = CGFloat(40)
        button.anchor(width: width, height: height)
        button.setTitle("Cancel", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.backgroundColor = ThemesOptions.buttonBackGColor
        button.layer.cornerRadius = 20
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        linkViews()
        setupKeyboardHiding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        textField.text = textValue.text
        let isInt = Float(textValue.text ?? "") ?? nil
        if(isInt != nil){textField.keyboardType = .numberPad}
        if(textLabel.text == "Password"){addPrivacyEyeButton()}
        configureView()
        configureLayout()
    }
    
    init(textLabel: UILabel, textValue: UILabel) {
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .overFullScreen
        self.textLabel = textLabel
        self.textValue = textValue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func linkViews(){
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        view.backgroundColor = .clear
        view.addSubview(blurEffectView)
        view.addSubview(contentView)
        contentView.backgroundColor = cellBackgColor
        contentView.addSubview(titleLabel)
        contentView.addSubview(textField)
        contentView.addSubview(doneButton)
        contentView.addSubview(cancelButton)
    }
    
    func configureView(){
        titleLabel.text = textLabel.text
        doneButton.addTarget(self, action: #selector(done), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
    }
    
    func addPrivacyEyeButton(){
        eyeButton = {
            let button = UIButton()
            let size = CGFloat(36)
            button.anchor(width: size, height: 36)
            button.setImage(UIImage(systemName: "eye.slash"), for: .normal)
            button.tintColor = ThemesOptions.buttonBackGColor
            textField.isSecureTextEntry = true
            textField.text = textValue.accessibilityIdentifier
            return button
        }()
        contentView.addSubview(eyeButton ?? UIButton())
        eyeButton?.addTarget(self, action: #selector(changeEyeAppearance), for: .touchUpInside)
    }
    
    @objc func changeEyeAppearance(){
        if(textField.isSecureTextEntry){
            eyeButton?.setImage(UIImage(systemName: "eye"), for: .normal)
            textField.isSecureTextEntry = false
        }else{
            eyeButton?.setImage(UIImage(systemName: "eye.slash"), for: .normal)
            textField.isSecureTextEntry = true
        }
    }
    
   @objc func done(){
       if (textLabel.text == "Password"){
           textValue.text = String(repeating: "* ", count: textField.text?.count ?? 0)
           textValue.accessibilityIdentifier = textField.text
       }else{ textValue.text = textField.text }
       
       self.dismiss(animated: true)
    }
    
    @objc func cancel(){
        self.dismiss(animated: true)
    }
    
    private func setupKeyboardHiding(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(sender: NSNotification){
        view.frame.origin.y = view.frame.origin.y - 100
    }
    
    @objc func keyboardWillHide(sender: NSNotification){
        view.frame.origin.y = 0
    }
    
    func configureLayout(){
        blurEffectView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        contentView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        contentView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        titleLabel.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, paddingTop: 24, paddingLeft: 16, paddingRight: 16)
        textField.anchor(top: titleLabel.bottomAnchor, left: titleLabel.leftAnchor, right: eyeButton?.leftAnchor ?? contentView.rightAnchor, paddingTop: 16, paddingRight: 16)
        eyeButton?.anchor(top: textField.topAnchor, bottom: textField.bottomAnchor, right: contentView.rightAnchor, paddingRight: 12)
        eyeButton?.centerYAnchor.constraint(equalTo: textField.centerYAnchor).isActive = true
        cancelButton.anchor(top: textField.bottomAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, paddingTop: 24, paddingLeft: 32, paddingBottom: 16)
        doneButton.anchor(top: cancelButton.topAnchor, bottom: cancelButton.bottomAnchor, right: contentView.rightAnchor, paddingLeft: 32, paddingRight: 32)
    }
}

