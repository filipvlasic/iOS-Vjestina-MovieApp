//
//  MovieTagTableViewCell.swift
//  MovieApp
//
//  Created by Filip Vlašić on 30.05.2023..
//

import UIKit

class MovieTagTableViewCell: UITableViewCell {
  
  private var selectedIndex = 0 {
    didSet {
      updateIndicatorConstraints()
      collectionView.reloadData()
    }
  }
  private var nsArrayConstraints: NSArray = .init(array: [])
  private var model: [MovieTag] = .init()
  
  private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
  private let indicator = UIView()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    addViews()
    styleViews()
    setupConstraints()
  }
  
  required init?(coder: NSCoder) { fatalError() }
  
  private func addViews() {
    contentView.addSubview(collectionView)
    contentView.addSubview(indicator)
  }
  
  private func styleViews() {
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.scrollDirection = .horizontal
    collectionView.collectionViewLayout = flowLayout
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.register(MovieTagCollectionViewCell.self, forCellWithReuseIdentifier: MovieTagCollectionViewCell.identifier)

    indicator.backgroundColor = .blue
  }
  
  private func setupConstraints() {
    collectionView.autoPinEdge(toSuperviewEdge: .leading, withInset: 16)
    collectionView.autoPinEdge(toSuperviewEdge: .trailing, withInset: 16)
    collectionView.autoPinEdge(toSuperviewEdge: .top)
    collectionView.autoPinEdge(toSuperviewEdge: .bottom)
    collectionView.autoSetDimension(.height, toSize: 50)
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    collectionView.reloadData()
  }
  
  private func updateIndicatorConstraints() {
    let selected = calculateLeadingCellsWidth()
    let offset = 16 - collectionView.contentOffset.x + CGFloat((selectedIndex * 24)) + selected
    
    nsArrayConstraints.autoRemoveConstraints()
    nsArrayConstraints = [
      indicator.autoPinEdge(toSuperviewEdge: .bottom, withInset: 8),
      indicator.autoPinEdge(toSuperviewEdge: .leading, withInset: offset),
      indicator.autoSetDimension(.height, toSize: 3),
      indicator.autoSetDimension(.width, toSize: calculateCellWidth(index: selectedIndex))
    ]
  }
  
  private func convertToTitle(_ movieTag: MovieTag) -> String {
    switch movieTag {
    case .forRent:
      return "For Rent"
    case .inTheaters:
      return "In Theaters"
    case .movie:
      return "Movies"
    case .onTv:
      return "On TV"
    case .streaming:
      return "Streaming"
    case .trendingThisWeek:
      return "This Week"
    case .trendingToday:
      return "Today"
    case .tvShow:
      return "TV"
    }
  }
  
  private func calculateCellWidth(index: Int) -> CGFloat {
    if model.isEmpty { return 0 }
    return convertToTitle(model[index]).size(withAttributes: [
        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .bold)
      ]).width
  }
  
  private func calculateLeadingCellsWidth() -> CGFloat {
    var sum:CGFloat = 0
    for i in (0..<selectedIndex) {
      sum += calculateCellWidth(index: i)
    }
    return sum
  }
  
}

extension MovieTagTableViewCell: Configurable {
  func configure(with model: Any) {
    guard let model = model as? MovieTagTableViewCellModel else { return }
    self.model = model.movieTags
    updateIndicatorConstraints()
    collectionView.reloadData()
  }
}

extension MovieTagTableViewCell: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    model.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieTagCollectionViewCell.identifier, for: indexPath) as? MovieTagCollectionViewCell else { return UICollectionViewCell() }
    
    let title = convertToTitle(model[indexPath.row])
    let color: UIColor = indexPath.row == selectedIndex ? .red : .blue
    cell.configure(with: title, color: color)
    
    return cell
  }
  
}

extension MovieTagTableViewCell: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    selectedIndex = indexPath.row
  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    updateIndicatorConstraints()
  }
}

extension MovieTagTableViewCell: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return .init(
      width: calculateCellWidth(index: indexPath.row),
      height: 50)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    24
  }
}
