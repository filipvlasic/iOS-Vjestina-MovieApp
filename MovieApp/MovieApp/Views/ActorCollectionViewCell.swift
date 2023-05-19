//
//  ActorCollectionViewCell.swift
//  MovieApp
//
//  Created by Filip Vlašić on 27.03.2023..
//

import UIKit

struct ActorModel {
  let actor: String
  let role: String
}

class ActorCollectionViewCell: UICollectionViewCell {
  
  private enum Constants {
    static let textColor: UIColor = .label
  }
  
  public static let identifier = "ActorCell"
  
  private let actor = UILabel()
  private let role = UILabel()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
        
    addViews()
    styleViews()
    setupConstraints()
  }
    
  required init?(coder: NSCoder) {
    fatalError()
  }
  
  private func addViews() {
    addSubview(actor)
    addSubview(role)
  }
  
  private func styleViews() {
    actor.textColor = Constants.textColor
    actor.font = .systemFont(ofSize: 14, weight: .bold)
    actor.numberOfLines = 1
    actor.adjustsFontSizeToFitWidth = true
    
    role.textColor = Constants.textColor
    role.font = .systemFont(ofSize: 14)
  }
  
  private func setupConstraints() {    
    actor.autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .bottom)
    
    role.autoPinEdge(.top, to: .bottom, of: actor, withOffset: 4)
    role.autoPinEdge(toSuperviewEdge: .leading)
    role.autoPinEdge(toSuperviewEdge: .trailing)
  }
  
}

extension ActorCollectionViewCell {
  public func configure(with model: ActorModel) {
    self.actor.text = model.actor
    self.role.text = model.role
  }
}
