//
//  Loan.swift
//  TableVIewPractice2
//
//  Created by 신미지 on 2021/06/21.
//

import Foundation


// #1와 #2의 model 구조
/*
struct Movie {
  var title: String = ""
  var count: Int = 0
  var date: String = ""
  var poster: String = ""
}
*/

// #3 Json Parse
struct Movie: Codable {
  var title: String = ""
  var count: Int = 0
  var date: String = ""
  var poster: String = ""
  
  enum CodingKeys: String, CodingKey {
    case title
    case count = "vote_count"
    case date = "release_date"
    case poster = "poster_path"
  }
  
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    title = try values.decode(String.self, forKey: .title)
    count = try values.decode(Int.self, forKey: .count)
    date = try values.decode(String.self, forKey: .date)
  }
}

struct MovieDataStore: Codable {
  var results: [Movie]
}

//struct Movie: Codable {
//  var title: String = ""
//  var count: Int = 0
//  var date: String = ""
//  var poster: String = ""
//
//  enum CodingKeys: String, CodingKey {
//    case title
//    case count = "vote_count"
//    case date = "release_date"
//    case poster = "poster_path"
//  }
//
//  init(from decoder: Decoder) throws {
//    let values = try decoder.container(keyedBy: CodingKeys.self)
//    title = try values.decode(String.self, forKey: .title)
//    count = try values.decode(Int.self, forKey: .count)
//    date = try values.decode(String.self, forKey: .date)
//    poster = try values.decode(String.self, forKey: .poster)
//
//  }
//}
//
//struct MovieDataStore: Codable {
//  var results: [Movie]
//}



//struct Loan: Codable {
//  var name: String = ""
//  var country: String = ""
//  var use: String = ""
//  var amount: Int = 0
//  var date: String = ""
//
//  enum CodingKeys: String, CodingKey {
//    case name
//    case country = "location"
//    case use
//    case amount = "loan_amount"
//    case date = "posted_date"
//  }
//
//  enum LocationKeys: String, CodingKey {
//    case country
//  }
//
//  init(from decoder: Decoder) throws {
//    let values = try decoder.container(keyedBy: CodingKeys.self)
//    name = try values.decode(String.self, forKey: .name)
//    use = try values.decode(String.self, forKey: .use)
//    amount = try values.decode(Int.self, forKey: .amount)
//    date = try values.decode(String.self, forKey: .date)
//    let location = try values.nestedContainer(keyedBy: LocationKeys.self, forKey: .country)
//    country = try location.decode(String.self, forKey: .country)
//  }
//}
//
//struct LoanDataStore : Codable {
//  var loans: [Loan]
//}
