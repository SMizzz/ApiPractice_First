//
//  BasicCell.swift
//  TableVIewPractice2
//
//  Created by 신미지 on 2021/06/21.
//

import UIKit

class BasicCell: UITableViewCell {
  let nameLabel: UILabel = {
    let label = UILabel()
    label.textColor = .black
    return label
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    backgroundColor = .white
    addSubview(nameLabel)
    nameLabel.translatesAutoresizingMaskIntoConstraints = false
    nameLabel.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
    nameLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
}
