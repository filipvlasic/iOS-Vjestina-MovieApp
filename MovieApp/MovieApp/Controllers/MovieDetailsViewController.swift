//
//  MovieDetailsViewController.swift
//  MovieApp
//
//  Created by Filip Vlašić on 25.03.2023..
//

import UIKit
import MovieAppData

class MovieDetailsViewController: UIViewController {
  
  private enum Constants {
    static let cellSpacing: CGFloat = 8
    static let cellHeight: CGFloat = 60
    static let numberOfItemsPerRow: CGFloat = 3
    static let textColor: UIColor = .systemBackground
    static let bacgroundColor: UIColor = .label
    static let leftPadding: CGFloat = 20
    static let rightPadding: CGFloat = 20
  }
  
  private var model: MovieDetailsModel?
  
  private let movieHeaderView = MovieHeaderView()
  private let overview = UILabel()
  private let summary = UILabel()
  private let collectioView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupViews()
    addViews()
    styleViews()
    setupConstraints()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    model = MovieUseCase().getDetails(id: 111161)
    styleViews()
    collectioView.reloadData()
  }
  
  private func setupViews() {
    collectioView.register(ActorCollectionViewCell.self, forCellWithReuseIdentifier: ActorCollectionViewCell.identifier)
    collectioView.dataSource = self
    collectioView.delegate = self
  }
  
  private func addViews() {
    view.addSubview(movieHeaderView)
    view.addSubview(collectioView)
    view.addSubview(overview)
    view.addSubview(summary)
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    movieHeaderView.applyGradient()
  }
  
  private func styleViews() {
    view.backgroundColor = Constants.bacgroundColor
    
    guard let model else { return }
    let movieHeaderViewModel =
    MovieHeaderViewModel(
      rating: model.rating,
      name: model.name,
      year: model.year,
      releaseDate: model.releaseDate,
      categories: model.categories,
      duration: model.duration,
      imageName: "shawshank.jpg")
    movieHeaderView.update(with: movieHeaderViewModel)
    
    overview.textColor = Constants.textColor
    overview.font = .systemFont(ofSize: 20, weight: .bold)
    overview.text = "Overview"
    
    summary.textColor = Constants.textColor
    summary.font = .systemFont(ofSize: 14)
    summary.lineBreakMode = .byWordWrapping
    summary.numberOfLines = 0
    summary.text = model.summary
    
    collectioView.backgroundColor = Constants.bacgroundColor
  }
  
  private func setupConstraints() {
    movieHeaderView.autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .bottom)
    // movieHeaderView.autoSetDimension(.height, toSize: 327)
    movieHeaderView.autoMatch(.height, to: .height, of: view, withMultiplier: 0.4)
    
    overview.autoPinEdge(.top, to: .bottom, of: movieHeaderView, withOffset: 22)
    overview.autoPinEdge(toSuperviewSafeArea: .leading, withInset: Constants.leftPadding)
    overview.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: Constants.rightPadding)
    
    summary.autoPinEdge(.top, to: .bottom, of: overview, withOffset: 8)
    summary.autoPinEdge(toSuperviewSafeArea: .leading, withInset: Constants.leftPadding)
    summary.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: Constants.rightPadding)
    
    collectioView.autoPinEdge(.top, to: .bottom, of: summary, withOffset: 30)
    collectioView.autoPinEdge(toSuperviewEdge: .leading, withInset: Constants.leftPadding)
    collectioView.autoPinEdge(toSuperviewEdge: .trailing, withInset: Constants.rightPadding)
    collectioView.autoPinEdge(toSuperviewEdge: .bottom)
  }
  
}

extension MovieDetailsViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    guard let model else { return 0 }
    return model.crewMembers.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ActorCollectionViewCell.identifier, for: indexPath) as? ActorCollectionViewCell else { return UICollectionViewCell()}
    
    guard let model else { return cell }
    let crewMember = model.crewMembers[indexPath.row]
    cell.configure(with: ActorModel(actor: crewMember.name, role: crewMember.role))
    return cell
  }
  
}


extension MovieDetailsViewController: UICollectionViewDelegate {
  
}

extension MovieDetailsViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.width / Constants.numberOfItemsPerRow - Constants.cellSpacing, height: Constants.cellHeight)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    Constants.cellSpacing
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    Constants.cellSpacing
  }
  
}
