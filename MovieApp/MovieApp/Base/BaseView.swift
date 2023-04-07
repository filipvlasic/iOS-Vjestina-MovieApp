//
//  BaseView.swift
//  MovieApp
//
//  Created by Filip Vlašić on 25.03.2023..
//

import UIKit

class BaseView: UIView {
  
  init() {
    super.init(frame: .zero)
    
    addViews()
    styleViews()
    setupConstraints()
  }
  
  @available(*, unavailable)
  required public init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  func addViews() {
    
  }
  
  func styleViews() {
    
  }
  
  func setupConstraints() {
    
  }
}
