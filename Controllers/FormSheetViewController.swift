//
//  FormSheetController.swift
//  MyJobAppTracker
//
//  Created by MICHAEL ADU DARKO on 11/23/21.
//

import UIKit

class FormSheetViewController: UIViewController, UITextFieldDelegate {
    
    //MARK:- Properties
    private let datePicker = UIDatePicker()
    
    private let backgroundView = Customview(color: .mainBlueTintColor)
    
    let stackScrollView = StackScrollView()
    
    
    private let cancelButton: UIButton = {
        let button = UIButton()
        button.tintColor = .white
        button.setDimensions(height: 50, width: 50)
        button.imageView?.setDimensions(height: 26, width: 26)
        button.layer.cornerRadius = 50 / 2
        button.backgroundColor = .systemRed
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.layer.shadowColor = UIColor.gray.cgColor
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 2
        button.layer.shadowOpacity = 1
        button.layer.shadowOffset = .zero
        button.layer.shadowRadius = 1
        return button
    }()
    
    
    private let doneButton: UIButton = {
        let button = UIButton()
        button.setDimensions(height: 50, width: 50)
        button.imageView?.setDimensions(height: 26, width: 26)
        button.layer.cornerRadius = 50 / 2
        button.tintColor = .white
        button.backgroundColor = .systemGreen
        button.setImage(UIImage(systemName: "checkmark"), for: .normal)
        button.layer.shadowColor = UIColor.gray.cgColor
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 2
        button.layer.shadowOpacity = 1
        button.layer.shadowOffset = .zero
        button.layer.shadowRadius = 1
        
        return button
    }()
    
    private let titleLabel : CustomLabel = {
        let label =  CustomLabel( name: Font.Futura, fontSize: 25 , color: .white)
        label.text = "Application Form"
        label.textAlignment = .center
        return label
    }()
    
    private let Company: FormTextField = {
        let tf = FormTextField(placeHolder: "Company Name")
        tf.heightAnchor.constraint(equalToConstant: 50).isActive = true
        tf.widthAnchor.constraint(equalToConstant: 12).isActive = true
        return tf
    }()
    
    private let jobTitle: FormTextField = {
        let tf = FormTextField(placeHolder: "Title")
        tf.heightAnchor.constraint(equalToConstant: 50).isActive = true
        tf.widthAnchor.constraint(equalToConstant: 10).isActive = true
        return tf
    }()
    
    private let date: FormTextField = {
        let tf = FormTextField(placeHolder: "Date")
        tf.heightAnchor.constraint(equalToConstant: 50).isActive = true
        tf.widthAnchor.constraint(equalToConstant: 10).isActive = true
        return tf
    }()
    
    private let location: FormTextField = {
        let tf = FormTextField(placeHolder: "Location")
        tf.heightAnchor.constraint(equalToConstant: 50).isActive = true
        tf.widthAnchor.constraint(equalToConstant: 10).isActive = true
        return tf
    }()
    
    private let jobLink: FormTextField = {
        let tf = FormTextField(placeHolder: "Listing URL Link")
        tf.heightAnchor.constraint(equalToConstant: 50).isActive = true
        tf.widthAnchor.constraint(equalToConstant: 10).isActive = true
        return tf
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        tapOutsideToDimissKeyboard()
        createDatePicker()
        Company.delegate = self
        jobLink.delegate = self
        date.delegate = self
        location.delegate = self
        jobTitle.delegate = self
    }
    
    //MARK:- Selectors
    
    @objc func cancelButtonTapped(){
        dismiss(animated: true, completion: nil)
        print("dismiss view")
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    @objc func keyboardwillhide(){
        stackScrollView.contentInset = .zero
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        stackScrollView.contentInset.bottom = view.convert(keyboardFrame.cgRectValue, from: nil).size.height
    }
    
    @objc func donePressed() {
        
        //formatter
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        date.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    
    //MARK:- Button Actions
    
    private func buttonAction(){
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
    }
    
    //MARK:- Helpers
    private func configureUI(){
        buttonAction()
        view.backgroundColor = .white
        
        view.addSubview(backgroundView)
        backgroundView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 5,paddingRight: 5, width: 130, height: 65)
        
        let topStack = UIStackView(arrangedSubviews: [cancelButton,UIView(), doneButton])
        topStack.translatesAutoresizingMaskIntoConstraints = false
        topStack.axis = .horizontal
        topStack.isLayoutMarginsRelativeArrangement = true
        topStack.distribution = .equalCentering
        topStack.layoutMargins = .init(top: 0, left: 16, bottom: 0, right: 16)
        
        backgroundView.addSubview(topStack)
        topStack.anchor(top: backgroundView.topAnchor, left: backgroundView.leftAnchor,right: backgroundView.rightAnchor , paddingTop: -20, paddingLeft: 10,paddingRight: 10)
        
        backgroundView.addSubview(titleLabel)
        titleLabel.anchor(top: topStack.bottomAnchor, left: backgroundView.leftAnchor, right: backgroundView.rightAnchor, paddingTop: -10)
        
        stackScrollView.backgroundColor = .white
        view.addSubview(stackScrollView)
        stackScrollView.anchor(top: backgroundView.bottomAnchor, left: view.leftAnchor,bottom: view.bottomAnchor,right: view.rightAnchor, paddingTop: 40, paddingLeft: 5, paddingBottom: 200 , paddingRight: 5 )
        
        
        let stackView = UIStackView(arrangedSubviews: [Company,jobTitle, date,location, jobLink])
        stackView.spacing = 15
        stackView.axis = .vertical
        
        stackScrollView.insertView(stackView)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardwillhide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        datePicker.frame = CGRect(x: 10, y: 50, width: self.view.frame.width, height: 200)
    }
    
    func tapOutsideToDimissKeyboard(){
        let tapOutside: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapOutside.cancelsTouchesInView = false
        view.addGestureRecognizer(tapOutside)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func createDatePicker(){
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: true)
        date.inputAccessoryView = toolbar
        date.inputView = datePicker
        
        datePicker.datePickerMode = .date
    }
    
   
}
