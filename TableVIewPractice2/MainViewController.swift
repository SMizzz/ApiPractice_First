//
//  MainViewController.swift
//  TableVIewPractice2
//
//  Created by 신미지 on 2021/06/21.
//

import UIKit

class MainViewController: UIViewController {
  // MARK: - Properties
  private let originalURLString = "https://api.kivaws.org/v1/loans/newest.json"
  private var loans = [Loan]()
  
  let restaurantCell = "restaurantCell"
  
  var restaurantNames = ["Cafe Deadend", "Homei", "Teakha", "Cafe Loisl", "Petite Oyster", "For Kee Restaurant", "Po's Atelier", "Bourke Street Bakery", "Haigh's Chocolate", "Palomino Espresso", "Upstate", "Traif", "Graham Avenue Meats", "Waffle & Wolf", "Five Leaves", "Cafe Lore", "Confessional", "Barrafina", "Donostia", "Royal Oak", "CASK Pub and Kitchen"]
  
  var restaurantLocations = ["Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Sydney", "Sydney", "Sydney", "New York", "New York", "New York", "New York", "New York", "New York", "New York", "London", "London", "London", "London"]
  
  var restaurantTypes = ["Coffee & Tea Shop", "Cafe", "Tea House", "Austrian / Causual Drink", "French", "Bakery", "Bakery", "Chocolate", "Cafe", "American / Seafood", "American", "American", "Breakfast & Brunch", "Coffee & Tea", "Coffee & Tea", "Latin American", "Spanish", "Spanish", "Spanish", "British", "Thai"]
  
  var restaurantImages = ["cafedeadend", "homei", "teakha", "cafeloisl", "petiteoyster", "forkeerestaurant", "posatelier", "bourkestreetbakery", "haighschocolate", "palominoespresso", "upstate", "traif", "grahamavenuemeats", "wafflewolf", "fiveleaves", "cafelore", "confessional", "barrafina", "donostia", "royaloak", "caskpubkitchen"]
  
  let tableView: UITableView = {
    let tv = UITableView()
    tv.backgroundColor = .white
    return tv
  }()
  
  // MARK: - Init
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    
    navigationItem.title = "Cafe"
    navigationController?.navigationBar.barTintColor = .white
    
    navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
    
    view.addSubview(tableView)
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    tableView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 45).isActive = true
    tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    
    tableView.register(RestaurantCell.self, forCellReuseIdentifier: restaurantCell)
    tableView.dataSource = self
    tableView.delegate = self
    
    getData()
  }
  
  func getData() {
    guard let loanURL = URL(string: originalURLString) else {
      return
    }
    
    let request = URLRequest(url: loanURL)
    
    URLSession.shared.dataTask(with: request) { [self] (data, response, error) in
//      print(data)
//      print(error)
//      print("::::::::::::::::::: \(response)")
      // 에러가 발생했을 때
      if error != nil {
        print(error?.localizedDescription)
        return
      }
      
      // 성공했을 때(데이터파싱)
      do {
        // data parsing
        let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
//        print(jsonResult)
        let jsonLoans = jsonResult!["loans"] as! [AnyObject]
        print(jsonLoans)
        
        for jsonLoan in jsonLoans {
          var loan = Loan()
          loan.name = jsonLoan["name"] as! String
          loan.amount = jsonLoan["loan_amount"] as! Int
          loan.date = jsonLoan["posted_date"] as! String
          loan.use = jsonLoan["use"] as! String
          let location = jsonLoan["location"] as! [String: AnyObject]
          loan.country = location["country"] as! String
          
          self.loans.append(loan)
        }
        
        OperationQueue.main.addOperation {
          self.tableView.reloadData()
        }
      } catch let error {
        print(error)
      }
    }.resume()
  }
  
  // MARK: - Handlers
  // MARK: - Constraints
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return loans.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: restaurantCell, for: indexPath) as! RestaurantCell
    
    let loanData = loans[indexPath.row]
    cell.restaurantImageView.image = UIImage(named: restaurantImages[indexPath.row])
    cell.restaurantNameLabel.text = loanData.name
    cell.restaurantLocationsLabel.text = loanData.country
    cell.restaurantTypesLabel.text = "$\(loanData.amount)"
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 80.0
  }
}
