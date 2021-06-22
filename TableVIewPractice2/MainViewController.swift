//
//  MainViewController.swift
//  TableVIewPractice2
//
//  Created by 신미지 on 2021/06/21.
//

import UIKit
import ProgressHUD
import Alamofire
import Kingfisher

class MainViewController: UIViewController {
  // MARK: - Properties
  private let originalURLString = "https://api.kivaws.org/v1/loans/newest.json"
  private let movieURLString = "https://api.themoviedb.org/3/movie/now_playing?api_key=8597e491ed6e80f0de12e349eb60ea6e&language=en-US&page=1"
//  private var loans = [Loan]()
  private var movies = [Movie]()
  let restaurantCell = "restaurantCell"
  let basicCellID = "basicCellId"
  
  var restaurantNames = ["Cafe Deadend", "Homei", "Teakha", "Cafe Loisl", "Petite Oyster", "For Kee Restaurant", "Po's Atelier", "Bourke Street Bakery", "Haigh's Chocolate", "Palomino Espresso", "Upstate", "Traif", "Graham Avenue Meats", "Waffle & Wolf", "Five Leaves", "Cafe Lore", "Confessional", "Barrafina", "Donostia", "Royal Oak", "CASK Pub and Kitchen"]
//
//  var restaurantLocations = ["Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Sydney", "Sydney", "Sydney", "New York", "New York", "New York", "New York", "New York", "New York", "New York", "London", "London", "London", "London"]
//
//  var restaurantTypes = ["Coffee & Tea Shop", "Cafe", "Tea House", "Austrian / Causual Drink", "French", "Bakery", "Bakery", "Chocolate", "Cafe", "American / Seafood", "American", "American", "Breakfast & Brunch", "Coffee & Tea", "Coffee & Tea", "Latin American", "Spanish", "Spanish", "Spanish", "British", "Thai"]
  
  var restaurantImages = ["cafedeadend", "homei", "teakha", "cafeloisl", "petiteoyster", "forkeerestaurant", "posatelier", "bourkestreetbakery", "haighschocolate", "palominoespresso", "upstate", "traif", "grahamavenuemeats", "wafflewolf", "fiveleaves", "cafelore", "confessional", "barrafina", "donostia", "royaloak", "caskpubkitchen"]
  
  let tableView: UITableView = {
    let tv = UITableView()
    tv.backgroundColor = .green
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
    tableView.register(BasicCell.self, forCellReuseIdentifier: basicCellID)
    
    tableView.dataSource = self
    tableView.delegate = self
    
    getData()
  }
  
  func getData() {
    guard let movieURL = URL(string: movieURLString) else {
      return
    }
    
    let request = URLRequest(url: movieURL)
    
    ProgressHUD.show()
    
    
    // #1 AF version - movie
    /*
    AF.request(request).responseData { (response) in
      print(response.result)
      switch response.result {
      case .success(let data):
        print(data)
        self.movies = self.parseJsonData(data: data)
        OperationQueue.main.addOperation {
          self.tableView.reloadData()
          ProgressHUD.dismiss()
        }
        break
      case .failure(let error):
        print(error)
        ProgressHUD.dismiss()
        break
      }
    }
 */
    
    // #2 URLSession - movie
    /*
    URLSession.shared.dataTask(with: request) { (data, response, error) in
      //에러가 발생했을 때
      if error != nil {
        print(error?.localizedDescription)
        ProgressHUD.dismiss()
        return
      }
      
      do {
        let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary

        let jsonMovies = jsonResult!["results"] as! [AnyObject]
        print("json movies \(jsonMovies)")
        
        for jsonMovie in jsonMovies {
          var movie = Movie()
          movie.title = jsonMovie["original_title"] as! String
          movie.date = jsonMovie["release_date"] as! String
          movie.count = jsonMovie["vote_count"] as! Int
          self.movies.append(movie)
        }
        
        OperationQueue.main.addOperation {
          self.tableView.reloadData()
          ProgressHUD.dismiss()
        }
        
        
      } catch let error {
        print(error)
        ProgressHUD.dismiss()
      }
    }.resume()
  */
    
    // #3 Json Parsing - movie
    
    URLSession.shared.dataTask(with: request) { [self] (data, response, error) in
      if error != nil {
        print(error?.localizedDescription)
        let errorMessage = error?.localizedDescription
        // 얼럿 띄우기
        ProgressHUD.dismiss()
        showAlert(error: errorMessage!)
        return
      }
      
      self.movies = self.parseJsonData(data: data!)
      OperationQueue.main.addOperation {
        self.tableView.reloadData()
        ProgressHUD.dismiss()
        return
      }
    }.resume()
    
    
    
//    //alamofire network
//    AF.request(request).responseData { (response) in
////      print(response)
//      switch response.result {
//      case .success(let data):
//        print(data)
//        self.loans = self.parseJsonData(data: data)
//        OperationQueue.main.addOperation {
//          self.tableView.reloadData()
//          ProgressHUD.dismiss()
//        }
//        break
//      case .failure(let error):
//        print(error)
//        ProgressHUD.dismiss()
//        break
//      }
//    }
    
//    URLSession.shared.dataTask(with: request) { [self] (data, response, error) in
////      print(data)
////      print(error)
////      print("::::::::::::::::::: \(response)")
//      // 에러가 발생했을 때
//      if error != nil {
//        print(error?.localizedDescription)
//        // 얼럿 띄우기
//        ProgressHUD.dismiss()
//        return
//      }
//
//      self.loans = self.parseJsonData(data: data!)
//
//      OperationQueue.main.addOperation {
//        self.tableView.reloadData()
//        ProgressHUD.dismiss()
//      }
      
    
    
//      do {
//        // data parsing
//        let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
////        print(jsonResult)
//        let jsonLoans = jsonResult!["loans"] as! [AnyObject]
//        print(jsonLoans)
//
//        for jsonLoan in jsonLoans {
//          var loan = Loan()
//          loan.name = jsonLoan["name"] as! String
//          loan.amount = jsonLoan["loan_amount"] as! Int
//          loan.date = jsonLoan["posted_date"] as! String
//          loan.use = jsonLoan["use"] as! String
//          let location = jsonLoan["location"] as! [String: AnyObject]
//          loan.country = location["country"] as! String
//
//          self.loans.append(loan)
//        }
//
//        OperationQueue.main.addOperation {
//          self.tableView.reloadData()
//        }
//      } catch let error {
//        print(error)
//      }
//    }.resume()
  }
  
  func parseJsonData(data: Data) -> [Movie] {
    do {
      let decoder = JSONDecoder()
      let movieDataStore = try decoder.decode(MovieDataStore.self, from: data)
      self.movies = movieDataStore.results
    } catch let error {
      print(error)
    }
    return movies
  }
  
  // 얼럿
  func showAlert(error: String) {
    print("==================================== \(error)")
    let alertVC = UIAlertController(title: "Error!", message: "\(error)", preferredStyle: .alert)
    alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    self.present(alertVC, animated: true, completion: nil)
  }
  
//  func parseJsonData(data: Data) -> [Loan] {
//    // 성공했을 때(데이터파싱)
//    do {
//      let decoder = JSONDecoder()
//      let loanDataStore = try decoder.decode(LoanDataStore.self, from: data)
//      self.loans = loanDataStore.loans
//    } catch let error {
//      print(error)
//    }
//    return loans
//  }
  
//  func parseJsonData(data: Data) -> [Movie] {
//    // 성공했을 때(데이터파싱)
//    do {
//      let decoder = JSONDecoder()
//      let movieDataStore = try decoder.decode(MovieDataStore.self, from: data)
//      self.movies = movieDataStore.results
//    } catch let error {
//      print(error)
//    }
//    return movies
//  }
  
  // MARK: - Handlers
  // MARK: - Constraints
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == 0 {
      return movies.count
    }
    return restaurantNames.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    if indexPath.section == 0 {
      let movieCell = tableView.dequeueReusableCell(withIdentifier: restaurantCell, for: indexPath) as! RestaurantCell
      
      let movieData = movies[indexPath.row]
      movieCell.restaurantImageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500\(movieData.poster)"))
//      movieCell.restaurantImageView.image = UIImage(named: movieData.poster)
      movieCell.restaurantNameLabel.text = movieData.title
      movieCell.restaurantLocationsLabel.text = movieData.date
      movieCell.restaurantTypesLabel.text = "$\(movieData.count)"
      return movieCell
    }
    
    let cell = tableView.dequeueReusableCell(withIdentifier: basicCellID, for: indexPath) as! BasicCell
    cell.nameLabel.text = restaurantNames[indexPath.row]
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 80.0
    
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 40.0
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    if section == 0 {
      return "movie"
    }
    return "restaurant"
  }
}
