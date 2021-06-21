//
//  Loan.swift
//  TableVIewPractice2
//
//  Created by 신미지 on 2021/06/21.
//

import Foundation

struct Loan: Codable {
  var name: String = ""
  var country: String = ""
  var use: String = ""
  var amount: Int = 0
  var date: String = ""
  
  enum CodingKeys: String, CodingKey {
    case name
    case country = "location"
    case use
    case amount = "loan_amount"
    case date = "posted_date"
  }
  
  enum LocationKeys: String, CodingKey {
    case country
  }
  
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    name = try values.decode(String.self, forKey: .name)
    use = try values.decode(String.self, forKey: .use)
    amount = try values.decode(Int.self, forKey: .amount)
    date = try values.decode(String.self, forKey: .date)
    let location = try values.nestedContainer(keyedBy: LocationKeys.self, forKey: .country)
    country = try location.decode(String.self, forKey: .country)
  }
}

struct LoanDataStore : Codable {
  var loans: [Loan]
}
