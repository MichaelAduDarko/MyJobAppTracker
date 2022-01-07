//
//  LoginController.swift
//  MyJobAppTracker
//
//  Created by MICHAEL ADU DARKO on 12/5/21.
//

import UIKit
import Lottie
import Firebase
import SCLAlertView

class LoginController: UIViewController, UITextFieldDelegate  {
    
    //MARK:- Properties
    private let animationView = AnimationView()
    
    private var viewModel = LoginViewModel()
    
    private let titlelabel: CustomLabel = {
        let label = CustomLabel( name: Font.Futura, fontSize: 28, color: .white)
        label.text = Constant.TitleLabel
      return label
    }()
    
    private let logInLabel: CustomLabel = {
        let label = CustomLabel( name: Font.Futura, fontSize: 25, color: .white)
        label.text = Constant.LogInLabel
       return label
    }()
    
    
    private let emailTextfield =  CustomTextField(placeholder: Constant.Email,autoCorrectionType: .no, secureTextEntry: false)
    
    private let passwordTextField = CustomTextField(placeholder: Constant.Password , secureTextEntry: true)
    
    private let loginButton: CustomButton = {
        let button = CustomButton(title: Constant.Login)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    private let forgotPasswordButton: CustomDontHaveAccountButton = {
        let button = CustomDontHaveAccountButton(title: Constant.ForgotPswd, secondtitle: Constant.RestPswd)
        button.addTarget(self, action: #selector(handleForgotPassword), for: .touchUpInside)
        return button
    }()
    
    private let dontHaveAccountButton: CustomDontHaveAccountButton = {
        let button = CustomDontHaveAccountButton(title: Constant.DontHaveAcc, secondtitle:Constant.SignUp)
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        return button
    }()
    
    
    //MARK:- Selectors
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func handleLogin(){
        
            guard let email = emailTextfield.text else { return}
            guard let password = passwordTextField.text  else { return}
            
            showLoader(true, withText: "Loggin In")
            
            AuthService.shared.logUserIn(withEmail: email, password: password) { (result, error) in
                if let error = error {
                    self.showLoader(false)
                    SCLAlertView().showError("error", subTitle: error.localizedDescription)
                    return
                    
                } else {
                    DispatchQueue.main.async {
                        SceneDelegate.routeToRootViewController()
                    }
                }
            }
    }
    
    @objc func handleForgotPassword(){
        let controller = RessetPasswordController()
        controller.email = emailTextfield.text
        controller.delegate = self
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func handleShowSignUp(){
        let controller = RegistrationController()
        navigationController?.pushViewController(controller, animated: true)
        
    }
    
    @objc func textDidChange(sender: UITextField){
        if sender == emailTextfield{
            viewModel.email = sender.text
        } else {
            viewModel.password = sender.text
        }
        checkFormStatus()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        tapOutsideToDimissKeyboard()
        configureTextFieldObservers()
        
        emailTextfield.delegate = self
        passwordTextField.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        animationView.play()
    }
    
    //MARK:- Helpers
    
    func checkFormStatus(){
        if viewModel.formIsValid {
            loginButton.isEnabled = true
            loginButton.backgroundColor = .systemPink
        } else {
            loginButton.isEnabled = false
            loginButton.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        }
        
    }
    
    func configureTextFieldObservers(){
        emailTextfield.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        
    }
    
    private func configureUI(){
        
        animationView.animation = Animation.named(LottieAnimation.notes)
        animationView.loopMode = .loop
        animationView.contentMode = .scaleAspectFit
        animationView.animationSpeed = 0.5
        animationView.play()
        
        
        view.backgroundColor = .mainBlueTintColor
        
        view.addSubview(animationView)
        animationView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                             left:  view.leftAnchor, right:  view.rightAnchor,
                             paddingRight: -200, width: 200, height: 200)
        
        
        view.addSubview(titlelabel)
        titlelabel.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                          left: view.leftAnchor,
                          paddingTop: 10, paddingLeft: 10)
        
        view.addSubview(logInLabel)
        logInLabel.anchor(top: titlelabel.bottomAnchor,left: view.leftAnchor,
                           paddingTop: 65, paddingLeft: 30)
        
        let stackView = UIStackView(arrangedSubviews:[emailTextfield,passwordTextField,
                                                      loginButton, forgotPasswordButton])
        stackView.checkIfAutoLayOut()
        stackView.axis = .vertical
        stackView.spacing = 13
        
        
        view.addSubview(stackView)
        stackView.anchor(top: logInLabel.bottomAnchor, left: view.leftAnchor,
                         right: view.rightAnchor, paddingTop: 15,
                         paddingLeft: 30, paddingRight: 30)
        
        
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                     right: view.rightAnchor, paddingLeft: 32, paddingRight: 32)
        
        animationView.alpha = 0
        loginButton.alpha = 0
        emailTextfield.alpha = 0
        passwordTextField.alpha = 0
        
        UIView.animate(withDuration: 2) {
            self.animationView.alpha = 1
            self.loginButton.alpha = 1
            self.emailTextfield.alpha = 1
            self.passwordTextField.alpha = 1
        }
        
    }
    
    ///Tap outside to dimiss keyboard
    func tapOutsideToDimissKeyboard(){
        let tapOutside: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapOutside.cancelsTouchesInView = false
        view.addGestureRecognizer(tapOutside)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


//MARK:- ResetPasswordControllerDelegate

extension LoginController: ResetPasswordControllerDelegate {
    func didSendResetPasswordLink() {
        navigationController?.popViewController(animated: true)
    }
}
