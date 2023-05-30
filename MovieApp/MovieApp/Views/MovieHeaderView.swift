//
//  MovieHeaderView.swift
//  MovieApp
//
//  Created by Filip Vlašić on 25.03.2023..
//

import UIKit

struct MovieHeaderViewModel {
  let rating: Double
  let name: String
  let year: Int
  let releaseDate: String
  let categories: [String]
  let duration: Int
  let imageUrl: URL?
  let image: UIImage
  let id: Int
  let didTapHeart: (Int) -> Void
}

class MovieHeaderView: BaseView {
  
  private enum Constants {
    static let textColor: UIColor = .white
    static let leftPadding: CGFloat = 20
  }
  
  private var movieId = 0
  private var didTapHeart: ((Int) -> Void)?
  
  private let headerImageView = UIImageView()
  private let rating = UILabel()
  private let userScore = UILabel()
  private let title = UILabel()
  private let releaseData = UILabel()
  private let categories = UILabel()
  private let starsButton = UIButton()
  
  override init() {
    super.init()
    setupActions()
  }
  
  override func addViews() {
    addSubview(headerImageView)
    addSubview(rating)
    addSubview(userScore)
    addSubview(title)
    addSubview(releaseData)
    addSubview(categories)
    addSubview(starsButton)
  }
  
  override func styleViews() {
    headerImageView.contentMode = .scaleAspectFill
    headerImageView.clipsToBounds = true
    
    rating.textColor = Constants.textColor
    rating.font = .systemFont(ofSize: 16, weight: .bold)
    
    userScore.textColor = Constants.textColor
    userScore.font = .systemFont(ofSize: 14)
    userScore.text = "User Score"
    
    title.textColor = Constants.textColor
    title.font = .systemFont(ofSize: 24, weight: .bold)
    title.lineBreakMode = .byWordWrapping
    title.numberOfLines = 0
    
    releaseData.textColor = Constants.textColor
    releaseData.font = .systemFont(ofSize: 14)
    
    categories.textColor = Constants.textColor
    categories.font = .systemFont(ofSize: 14)
    categories.lineBreakMode = .byWordWrapping
    categories.numberOfLines = 0
    
    starsButton.layer.cornerRadius = 16
    starsButton.backgroundColor = .gray
    starsButton.tintColor = Constants.textColor
  }
  
  override func setupConstraints() {
    headerImageView.autoPinEdgesToSuperviewEdges()
    
    rating.autoPinEdge(toSuperviewSafeArea: .top, withInset: 0, relation: .greaterThanOrEqual)
    rating.autoPinEdge(.bottom, to: .top, of: title, withOffset: -16)
    rating.autoPinEdge(toSuperviewSafeArea: .leading, withInset: Constants.leftPadding)
    
    userScore.autoPinEdge(.leading, to: .trailing, of: rating, withOffset: 8)
    userScore.autoAlignAxis(.horizontal, toSameAxisOf: rating)
    
    title.autoPinEdge(.bottom, to: .top, of: releaseData, withOffset: -16)
    title.autoPinEdge(toSuperviewSafeArea: .leading, withInset: Constants.leftPadding)
    title.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 20)
    
    releaseData.autoPinEdge(.bottom, to: .top, of: categories)
    releaseData.autoPinEdge(toSuperviewSafeArea: .leading, withInset: Constants.leftPadding)
    
    categories.autoPinEdge(.bottom, to: .top, of: starsButton, withOffset: -16)
    categories.autoPinEdge(toSuperviewSafeArea: .leading, withInset: Constants.leftPadding)
    
    starsButton.autoPinEdge(toSuperviewSafeArea: .leading, withInset: Constants.leftPadding)
    starsButton.autoPinEdge(toSuperviewSafeArea: .bottom, withInset: 20)
    starsButton.autoSetDimensions(to: CGSize(width: 32, height: 32))
  }
  
  private func setupActions() {
    starsButton.addTarget(self, action: #selector(tap), for: .touchUpInside)
  }
  
  @objc
  private func tap() {
    guard let favoriteMovies = Preferences.favoriteMoviesIds else { return }
    var movieIds = Preferences.favoriteMoviesIds!
    if favoriteMovies.contains(movieId) {
      movieIds.removeAll { id in
        id == movieId
      }
      Preferences.favoriteMoviesIds = movieIds
    } else {
      movieIds.append(movieId)
      Preferences.favoriteMoviesIds = movieIds
    }
    didTapHeart?(movieId)
  }
  
  func moveTextAway(position: CGFloat) {
    makeTransparent(views: [rating, userScore, title, releaseData, categories])
    translateAway(position: position, views: [rating, userScore, title, releaseData, categories])
  }
  
  func moveTextToOriginalPosition() {
    makeVisible([rating, userScore, title, releaseData, categories])
    translateToOriginalPosition(views: [rating, userScore, title, releaseData, categories])
  }
  
  private func makeTransparent(views: [UIView]) {
    views.forEach { $0.alpha = 0 }
  }
  
  private func makeVisible(_ views: [UIView]) {
    views.forEach { $0.alpha = 1 }
  }
  
  private func translateAway(position: CGFloat, views: [UIView]) {
    views.forEach { $0.transform = $0.transform.translatedBy(x: -position, y: 0) }
  }
  
  private func translateToOriginalPosition(views: [UIView]) {
    views.forEach { $0.transform = .identity }
  }
  
  public func applyGradient() {
    if rating.frame.origin.y > 0 { // 2 poziva???
      let colorTop =  UIColor.clear.cgColor
      let colorBottom = UIColor.black.cgColor
      let gradientLayer = CAGradientLayer()
      gradientLayer.colors = [colorTop, colorBottom]
      gradientLayer.frame =
        CGRect(x: 0,
               y: rating.frame.origin.y,
               width: bounds.width,
               height: bounds.height - rating.frame.origin.y)
      headerImageView.layer.addSublayer(gradientLayer)
    }
  }
  
}

extension MovieHeaderView {
  func update (with model: MovieHeaderViewModel) {
    headerImageView.kf.setImage(with: model.imageUrl)
    rating.text = "\(model.rating)"
    title.text = "\(model.name) (\(model.year))"
    releaseData.text = "\(model.releaseDate) (US)"
    categories.attributedText = convertCategories(model.categories, duration: model.duration)
    starsButton.setImage(model.image, for: .normal)
    movieId = model.id
    self.didTapHeart = model.didTapHeart
  }
  
  private func convertCategories(_ categories: [String], duration: Int) -> NSAttributedString {
    let normalText = categories.map { "\($0)".capitalized }.joined(separator: ", ")
    let boldText = convertMinutesToHours(duration)
    
    let attributedString = NSMutableAttributedString(string:normalText)
    let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)]
    let boldString = NSMutableAttributedString(string: boldText, attributes:attrs)
    attributedString.append(boldString)
    return attributedString
  }
  
  private func convertMinutesToHours(_ time: Int) -> String {
    let hours = time / 60
    let minutes = time % 60
    return "  \(hours)h \(minutes)m"
  }
}
