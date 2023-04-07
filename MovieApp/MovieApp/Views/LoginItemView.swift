//
//  LoginItemView.swift
//  MovieApp
//
//  Created by Filip Vlašić on 25.03.2023..
//

import UIKit
import PureLayout

struct LoginItemViewModel {
  let title: String
  let placeholder: String?
  let keyboardType: UIKeyboardType
  let hiddenText: Bool
}

class LoginItemView: BaseView {
  
  enum Constatns {
    static let titleColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
    static let textFieldBackgorundColor = UIColor(red: 19/255, green: 59/255, blue: 99/255, alpha: 1.0)
    static let placeholderColor = UIColor(red: 76/255, green: 178/255, blue: 223/255, alpha: 1.0)
    static let cornerRadius: CGFloat = 10
  }
  
  private let title = UILabel()
  private let textField = UITextField()
  
  override func addViews() {
    addSubview(title)
    addSubview(textField)
  }
  
  override func styleViews() {
    title.textColor = Constatns.titleColor
    title.font = .systemFont(ofSize: 14)
    
    textField.backgroundColor = Constatns.textFieldBackgorundColor
    textField.layer.cornerRadius = Constatns.cornerRadius
    textField.textColor = .white
    textField.autocapitalizationType = .none
    textField.setLeftPadding(16)
  }
  
  override func setupConstraints() {
    
    
    title.autoPinEdge(toSuperviewEdge: .top)
    title.autoPinEdge(toSuperviewEdge: .leading)
    title.autoSetDimension(.height, toSize: 20)
    
    textField.autoPinEdge(.top, to: .bottom, of: title, withOffset: 8)
    textField.autoPinEdge(toSuperviewEdge: .leading)
    textField.autoPinEdge(toSuperviewEdge: .trailing)
    textField.autoSetDimension(.height, toSize: 48)
    textField.autoPinEdge(toSuperviewEdge: .bottom)
  }
  
}

extension LoginItemView {
  func update(with model: LoginItemViewModel) {
    title.text = model.title
    
    textField.isSecureTextEntry = model.hiddenText
    textField.attributedPlaceholder = getPlaceholder(placeholder: model.placeholder)
  }
  
  private func getPlaceholder(placeholder: String?) -> NSAttributedString {
    guard let placeholder else { return NSAttributedString(string: "")}
    return NSAttributedString(
      string: placeholder,
      attributes: [NSAttributedString.Key.foregroundColor: Constatns.placeholderColor])
  }
}

extension UITextField {
  func setLeftPadding(_ padding: CGFloat) {
    let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: self.frame.height))
    self.leftView = leftPaddingView
    self.leftViewMode = .always
  }
}
