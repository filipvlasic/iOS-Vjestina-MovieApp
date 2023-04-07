//
//  LogInViewController.swift
//  MovieApp
//
//  Created by Filip Vlašić on 25.03.2023..
//

import UIKit
import PureLayout

class LogInViewController: UIViewController {
  
  enum Constatns {
    static let title: String = "Sign In"
    static let backgorundColor: UIColor = UIColor(red: 11/255, green: 37/255, blue: 63/255, alpha: 1.0)
    static let buttonBackgroundColor = UIColor(red: 76/255, green: 178/255, blue: 223/225, alpha: 1)
  }
  
  private let signInTitle = UILabel()
  private let emailField = LoginItemView()
  private let passwordField = LoginItemView()
  private let button = UIButton()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    addViews()
    styleViews()
    setupConstraints()
  }
  
  private func addViews() {
    view.addSubview(signInTitle)
    view.addSubview(emailField)
    view.addSubview(passwordField)
    view.addSubview(button)
  }
  
  private func styleViews() {
    self.view.backgroundColor = Constatns.backgorundColor
    
    signInTitle.text = Constatns.title
    signInTitle.font = .systemFont(ofSize: 24, weight: .bold)
    signInTitle.textColor = .white
    signInTitle.textAlignment = .center
    
    emailField.update(with: LoginItemViewModel(
      title: "Email address",
      placeholder: "ex. filipvlasic2008@gmail.com",
      keyboardType: .emailAddress,
      hiddenText: false))
    
    passwordField.update(with: LoginItemViewModel(
      title: "Password",
      placeholder: "Enter your password",
      keyboardType: .default,
      hiddenText: true))
    
    button.layer.cornerRadius = 10
    button.backgroundColor = Constatns.buttonBackgroundColor
    button.setTitle("Sign in", for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: 14)
  }
  
  private func setupConstraints() {
    signInTitle.autoPinEdge(toSuperviewSafeArea: .top, withInset: 36)
    signInTitle.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 16)
    signInTitle.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 16)
    
    emailField.autoPinEdge(.top, to: .bottom, of: signInTitle, withOffset: 48)
    emailField.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 16)
    emailField.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 16)
    
    passwordField.autoPinEdge(.top, to: .bottom, of: emailField, withOffset: 24)
    passwordField.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 16)
    passwordField.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 16)
    
    button.autoPinEdge(.top, to: .bottom, of: passwordField, withOffset: 48)
    button.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 32)
    button.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 32)
    button.autoSetDimension(.height, toSize: 40)
  }
  
}
