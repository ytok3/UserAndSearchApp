//
//  LoginViewController.swift
//  UserAndSearchApp
//
//  Created by Yasemin TOK on 28.06.2022.
//

import UIKit
import Toaster

final class LoginViewController: UIViewController {
    
    private let mail = "admin@gmail.com"
    private let password = "123456"

    private var searchVC: SearchViewController = SearchViewController()
    
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textColor = .black
        label.backgroundColor = .white
        label.font = UIFont.systemFont(ofSize: 30)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = Constant.Properties.WELCOME
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let verticalStack: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.alignment = .center
        sv.spacing = 20
        sv.axis = .vertical
        return sv
    }()
    
    private var mailTextField: UITextField = {
        let text = UITextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.clipsToBounds = true
        text.textColor = .black
        text.font = UIFont.systemFont(ofSize: 15)
        text.placeholder = Constant.Properties.MAIL
        text.borderStyle = .roundedRect
        text.backgroundColor = .white
        text.layer.cornerRadius = 5
        text.autocapitalizationType = .none
        text.autocorrectionType = .no
        text.textContentType = .emailAddress
        return text
    }()
    
    private var passwordTextField: UITextField = {
        let text = UITextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.clipsToBounds = true
        text.textColor = .black
        text.font = UIFont.systemFont(ofSize: 15)
        text.placeholder = Constant.Properties.PASSWORD
        text.textAlignment = .left
        text.borderStyle = .roundedRect
        text.backgroundColor = .white
        text.layer.cornerRadius = 5
        text.isSecureTextEntry = true
        return text
    }()
    
    private var loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.setTitle(Constant.Properties.LOGIN, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemYellow
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(clicked), for: .touchUpInside)
        return button
    }()
    
    private let toast = Toast(text: Constant.Properties.ERROR)

    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
    }
    
    // MARK: Func
    
    func setUpView() {
        
        self.navigationController?.isNavigationBarHidden = false
                
        view.backgroundColor = .white
                
        view.addSubview(welcomeLabel)
        view.addSubview(verticalStack)
        verticalStack.addArrangedSubview(mailTextField)
        verticalStack.addArrangedSubview(passwordTextField)
        verticalStack.addArrangedSubview(loginButton)
        
    setUpConstraint()
        
    }
    
    private func setUpConstraint() {
        
        let padding: CGFloat = 4
        
        NSLayoutConstraint.activate([
            
            welcomeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding * 20),
            welcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            welcomeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            verticalStack.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: padding),
            verticalStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            verticalStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            verticalStack.widthAnchor.constraint(equalToConstant: view.frame.width - padding * 2),
            
            mailTextField.topAnchor.constraint(equalTo: verticalStack.topAnchor, constant: padding * 30),
            mailTextField.heightAnchor.constraint(equalToConstant: view.frame.height / 20),
            mailTextField.widthAnchor.constraint(equalToConstant: view.frame.width / 1.25),
            
            passwordTextField.topAnchor.constraint(equalTo: mailTextField.bottomAnchor, constant: padding * 4),
            passwordTextField.heightAnchor.constraint(equalToConstant: view.frame.height / 20),
            passwordTextField.widthAnchor.constraint(equalToConstant: view.frame.width / 1.25),
            
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: padding * 5),
            loginButton.heightAnchor.constraint(equalToConstant: view.frame.height / 20),
            loginButton.widthAnchor.constraint(equalToConstant: view.frame.width / 1.25)
    
        ])
    }
    
    @objc func clicked() {
        
        if mail == mailTextField.text && password == passwordTextField.text {
            navigationController?.pushViewController(searchVC, animated: true)
            mailTextField.text?.removeAll()
            passwordTextField.text?.removeAll()
            
        } else {
            toast.show()
            mailTextField.text?.removeAll()
            passwordTextField.text?.removeAll()
        }
    }
}
