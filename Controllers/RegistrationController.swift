//
//  RegistrationController.swift
//  MyJobAppTracker
//
//  Created by MICHAEL ADU DARKO on 12/7/21.
//

import UIKit
import Firebase
import JGProgressHUD
import SCLAlertView
import SDWebImage


class RegistrationController: UIViewController, UITextFieldDelegate {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK:- Properties
    private var viewModel = RegistrationViewModel()
    
    private var profileImage: UIImage?
    
    private let plusPhotoButton: UIButton = {
        let button = UIButton (type: .system)
        button.setImage(#imageLiteral(resourceName: "plus_photo"), for: .normal)
        button.tintColor = .backgroundColor
        button.addTarget(self, action: #selector(handleAddProfilePhoto), for: .touchUpInside)
        button.imageView?.contentMode = .scaleAspectFill
        button.clipsToBounds = true
        button.imageView?.clipsToBounds = true
        return button
    }()
    
    private let emailTextfield =  CustomTextField(placeholder: Constant.Email ,autoCorrectionType: .no, secureTextEntry: false)
    
    private let fullNameTextfield =  CustomTextField(placeholder: Constant.FullName,autoCorrectionType: .no, secureTextEntry: false)
    
    private let jobTitleTextfield =  CustomTextField(placeholder: Constant.JobTitle,autoCorrectionType: .no, secureTextEntry: false)
    
    private let passwordTextField = CustomTextField (placeholder: Constant.Password, secureTextEntry: true)
    
    private let SignUpButton: CustomButton = {
        let button = CustomButton(title: Constant.SignUp)
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return button
    }()
    
    
    private let dontHaveAccountButton: CustomDontHaveAccountButton = {
        let button = CustomDontHaveAccountButton(title: Constant.AlreadyHaveAcc, secondtitle: Constant.Login)
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        return button
    }()
    
    //MARK:- Selectors
    
    @objc func handleAddProfilePhoto(){
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    
    @objc func handleSignUp(){
        guard let  email = emailTextfield.text else { return}
        guard let fullname = fullNameTextfield.text else {return }
        guard let jobTitle = jobTitleTextfield.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let profileImage = self.profileImage else { return }

        showLoader(true, withText: "Signing Up")

        let credentilas = RegistrationCredentials(email: email, fullName: fullname,password: password, jobTitle: jobTitle, profileImage: profileImage)


        AuthService.shared.createUser(credentials: credentilas) { (error) in
            self.showLoader(false)
            if let error = error {
                SCLAlertView().showError("error", subTitle: error.localizedDescription)
                print("debug: \(error.localizedDescription)")
                return

            }
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func handleShowLogin(){
        //Takes user back to login View after signing up
        navigationController?.popViewController(animated: true)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    //Form Validation
    @objc func textDidChange(sender: UITextField){
        if sender == emailTextfield{
            viewModel.email = sender.text
        } else if sender == fullNameTextfield{
            viewModel.fullname = sender.text
        } else if sender == jobTitleTextfield{
            viewModel.jobTitle = sender.text
        } else {
            viewModel.password = sender.text
        }
        checkFormStatus()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextFieldObservers()
        tapOutsideToDimissKeyboard()
        configureUI()
        emailTextfield.delegate = self
        fullNameTextfield.delegate = self
        jobTitleTextfield.delegate = self
        passwordTextField.delegate = self
    }
    
    /// Checks if form is valid to enable the button for click
    func checkFormStatus(){
        if viewModel.formIsValid {
            SignUpButton.isEnabled = true
            SignUpButton.backgroundColor = .systemPink
        } else {
            SignUpButton.isEnabled = false
            SignUpButton.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        }
        
    }
    
    
    /// Alerts observers when the text in a text field changes
    func configureTextFieldObservers(){
        emailTextfield.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        fullNameTextfield.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        jobTitleTextfield.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        
    }
    
    private func configureUI(){
        view.backgroundColor = .mainBlueTintColor
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(plusPhotoButton)
        plusPhotoButton.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor, paddingTop: 10)
        plusPhotoButton.setDimensions(height: 200, width: 200)
        
        
        let stackView = UIStackView(arrangedSubviews: [emailTextfield,fullNameTextfield,jobTitleTextfield,passwordTextField, SignUpButton])
        stackView.checkIfAutoLayOut()
        stackView.axis = .vertical
        stackView.spacing = 16
        
        
        view.addSubview(stackView)
        stackView.anchor(top: plusPhotoButton.bottomAnchor, left: view.leftAnchor,
                         right: view.rightAnchor, paddingTop: 20,
                         paddingLeft: 30, paddingRight: 30)
        
        
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                     right: view.rightAnchor, paddingLeft: 32, paddingRight: 32)
        
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

//MARK:- UIImagePickerControllerDelegate

extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
        profileImage = image
        plusPhotoButton.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
        plusPhotoButton.layer.borderColor = UIColor(white: 1, alpha: 0.7).cgColor
        plusPhotoButton.layer.borderWidth = 3.0
        plusPhotoButton.layer.cornerRadius = 200 / 2
        
        self.dismiss(animated: true, completion: nil)
    }
}
