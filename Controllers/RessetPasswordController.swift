//
//  RessetPasswordController.swift
//  MyJobAppTracker
//
//  Created by MICHAEL ADU DARKO on 12/8/21.
//

import UIKit
import Lottie

protocol ResetPasswordControllerDelegate: class {
    func didSendResetPasswordLink()
}

class RessetPasswordController: UIViewController , UITextFieldDelegate {
    
    //MARK:- Properties
    
    var email: String?
    weak var delegate: ResetPasswordControllerDelegate?
    
    private var viewModel = ResetPasswordViewModel()
    
    private let animationView = AnimationView()
    
    private let emailTextfield =  CustomTextField(placeholder: Constant.Email,autoCorrectionType: .no, secureTextEntry: false)
    
    private let resetPasswordButton: CustomButton = {
        let button = CustomButton(title: Constant.RestPswd)
        button.addTarget(self, action: #selector(handleResetPassword), for: .touchUpInside)
        return button
    }()
    
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(handleDismissal), for: .touchUpInside)
        button.setImage(UIImage(systemName: ImageSystemName.ChevronLeft), for: .normal)
        button.imageView?.setDimensions(height: 30, width: 26)
        button.tintColor = .white
        return button
    }()
   
    //MARK:- LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        tapOutsideToDimissKeyboard()
        emailTextfield.delegate = self
        configureTextFieldObservers()
        loadEmail()
    }
    
    
    //MARK:- Selectors
    
    @objc func handleResetPassword(){
//        guard let email = viewModel.email else { return }
//
//        showLoader(true, withText: "Loading ..")
//
//        AuthService.resetPassword(forEmail: email) { error  in
//
//            if let error = error {
//                self.showLoader(false)
//                SCLAlertView().showError("error", subTitle: error.localizedDescription)
//
//                return
//
//            }
//
//            self.showLoader(false)
//            self.delegate?.didSendResetPasswordLink()
//            SCLAlertView().showSuccess("Success", subTitle: "We sent a link to your email to reset password")
//
//        }
    }
    
    @objc func handleDismissal(){
        navigationController?.popViewController(animated: true)
    }
    
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    @objc func textDidChange(sender: UITextField){
        if sender == emailTextfield{
            viewModel.email = sender.text
        }
        checkFormStatus()
    }
    
    
    func checkFormStatus(){
        if viewModel.formIsValid {
            resetPasswordButton.isEnabled = true
            resetPasswordButton.backgroundColor = .systemPink
        } else {
            resetPasswordButton.isEnabled = false
            resetPasswordButton.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        }
        
    }
    //MARK:- Helpers
    
    func configureTextFieldObservers(){
        emailTextfield.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
    func configureUI(){
        
        animationView.animation = Animation.named(LottieAnimation.resetPassWrd)
        animationView.loopMode = .loop
        animationView.contentMode = .scaleAspectFit
        animationView.animationSpeed = 0.5
        animationView.play()

        view.backgroundColor = .mainBlueTintColor
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(backButton)
        backButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, paddingTop: 16, paddingLeft: 16)
        
        view.addSubview(animationView)
        animationView.centerX(inView: view)
        animationView.setDimensions(height: 250, width: 250)
        animationView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 35)
        
        let stackView = UIStackView(arrangedSubviews:[emailTextfield,resetPasswordButton])
        stackView.checkIfAutoLayOut()
        stackView.axis = .vertical
        stackView.spacing = 10
        
        view.addSubview(stackView)
        stackView.anchor(top: animationView.bottomAnchor, left: view.leftAnchor,
                         right: view.rightAnchor, paddingTop: 15,
                         paddingLeft: 30, paddingRight: 30)
        
        animationView.alpha = 0
        
        UIView.animate(withDuration: 2) {
            self.animationView.alpha = 1
        }
        
    }
    
    func loadEmail(){
        guard let email = email else { return }
        viewModel.email = email
        emailTextfield.text = email
        
        checkFormStatus()
    }
    
    //Keyboard dismissal when user taps outside
    func tapOutsideToDimissKeyboard(){
        let tapOutside: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapOutside.cancelsTouchesInView = false
        view.addGestureRecognizer(tapOutside)
    }
    
    //Return Key to dismiss keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

