//
//  RestaurantCell.swift
//  TableVIewPractice2
//
//  Created by 신미지 on 2021/06/21.
//

import UIKit

class RestaurantCell: UITableViewCell {
  // MARK: - Properties
  let restaurantImageView: UIImageView = {
    let iv = UIImageView()
    var image = UIImage()
    iv.image = image
    iv.clipsToBounds = true
    iv.layer.cornerRadius = 35
    return iv
  }()
  
  let restaurantNameLabel: UILabel = {
    let label = UILabel()
    label.textColor = .black
    return label
  }()
  
  let restaurantLocationsLabel: UILabel = {
    let label = UILabel()
    label.textColor = .black
    return label
  }()
  
  let restaurantTypesLabel: UILabel = {
    let label = UILabel()
    label.textColor = .black
    return label
  }()
  
  // MARK: - Init
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setup()
    addViews()
    setConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Handlers
  private func setup() {
    backgroundColor = .white
  }
  
  private func addViews() {
    addSubview(restaurantImageView)
    addSubview(restaurantNameLabel)
    addSubview(restaurantLocationsLabel)
    addSubview(restaurantTypesLabel)
  }
  
  private func setConstraints() {
    restaurantImageViewConstraints()
    restaurantNameLabelConstraints()
    restaurantLocationsLabelConstraints()
    restaurantTypesLabelConstraints()
  }
  
  // MARK: - Constraints
  private func restaurantImageViewConstraints() {
    restaurantImageView.translatesAutoresizingMaskIntoConstraints = false
    restaurantImageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
    restaurantImageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
    restaurantImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    restaurantImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
  }
  
  private func restaurantNameLabelConstraints() {
    restaurantNameLabel.translatesAutoresizingMaskIntoConstraints = false
    restaurantNameLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
    restaurantNameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    restaurantNameLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
    restaurantNameLabel.leadingAnchor.constraint(equalTo: restaurantImageView.leadingAnchor, constant: 80).isActive = true
  }
  
  private func restaurantLocationsLabelConstraints() {
    restaurantLocationsLabel.translatesAutoresizingMaskIntoConstraints = false
    restaurantLocationsLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
    restaurantLocationsLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    restaurantLocationsLabel.topAnchor.constraint(equalTo: restaurantNameLabel.bottomAnchor, constant: 5).isActive = true
    restaurantLocationsLabel.leadingAnchor.constraint(equalTo: restaurantNameLabel.leadingAnchor).isActive = true
  }
  
  private func restaurantTypesLabelConstraints() {
    restaurantTypesLabel.translatesAutoresizingMaskIntoConstraints = false
    restaurantTypesLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
    restaurantTypesLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    restaurantTypesLabel.topAnchor.constraint(equalTo: restaurantLocationsLabel.bottomAnchor, constant: 5).isActive = true
    restaurantTypesLabel.leadingAnchor.constraint(equalTo: restaurantNameLabel.leadingAnchor).isActive = true
  }
}
