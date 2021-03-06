//
//  FoodCVC.swift
//  Leuk_iOS
//
//  Created by yuvraj singh on 16/04/17.
//  Copyright © 2017 yuvi0049. All rights reserved.
//

import UIKit
import SwiftyJSON
import CoreLocation

private let reuseIdentifier = "Cell"

class FoodCVC: UICollectionViewController {
	//var indexValues: Int!
	var indexValueSecond: Int!
	var menuFoodId: String!
	var valueForSecondApiCall: Int!
	
	
	var statusLocal: String!

	@IBOutlet var myCollectionView: UICollectionView!
       override func viewDidLoad() {
        super.viewDidLoad()

	valueForSecondApiCall = 1000
	placeServiceStatusForPayment = 0
	
	cartValues.removeAll()
	
	let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
	
	layout.itemSize = CGSize(width: self.view.frame.width * 0.485, height: self.view.frame.height * 0.33)
//	layout.minimumInteritemSpacing = 0
	layout.minimumLineSpacing = 10
	
	myCollectionView.collectionViewLayout = layout
	//self.collectionViewLayout = layout

//	groceriesForShop.removeAll()
//	foodForShop.removeAll()
//	medicineForShop.removeAll()
//	stationaryForShop.removeAll()
	
	
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
	
	

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
	
	
        return 1
    }




    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

	
	
	
	
	if(indexValueSecond == 0){
		if restaurantOrder.count == 0 {
			DispatchQueue.main.async {
				
				_ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.reload), userInfo: nil, repeats: false);
			}
		}else{
			return restaurantOrder.count
		}
		return restaurantOrder.count
		
	}
	else if(indexValueSecond == 1){
		if GroceriesOrder.count == 0 {
			DispatchQueue.main.async {
				
				_ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.reload), userInfo: nil, repeats: false);
			}
		}else{
			return GroceriesOrder.count
		}
		
		
		return GroceriesOrder.count
	}
	else if(indexValueSecond == 2){
		if MedicineOrder.count == 0 {
			DispatchQueue.main.async {
				
				_ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.reload), userInfo: nil, repeats: false);
			}
		}else{
			return MedicineOrder.count
		}
		return MedicineOrder.count
	}
	else {
		if staitionaryOrder.count == 0 {
			DispatchQueue.main.async {
				
				_ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.reload), userInfo: nil, repeats: false);
			}
		}else{
			return staitionaryOrder.count
		}
		
		
		return staitionaryOrder.count
	}
    }
	func reload(){
		
		

		collectionView?.reloadData()
	}

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "foodcvcell", for: indexPath) as! FoodCVCell
	
	
	
	//cell.layer.borderColor = UIColor.gray.cgColor
	//cell.layer.borderWidth = 1.0
	
	
	
	cell.layer.shadowColor = UIColor.gray.cgColor
	cell.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
	cell.layer.shadowRadius = 2.0
	cell.layer.shadowOpacity = 0.6
	cell.layer.masksToBounds = false
	cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).cgPath
	
	  if(indexValueSecond == 0){
		  updateValues(restaurantOrder, cellForRow: indexPath, TableCell: cell)
	  }
	  else if(indexValueSecond == 1){
		  updateValues(GroceriesOrder, cellForRow: indexPath, TableCell: cell)
	  }
	  else if(indexValueSecond == 2){
		  updateValues(MedicineOrder, cellForRow: indexPath, TableCell: cell)
	  }
	  else if(indexValueSecond == 3){
		  updateValues(staitionaryOrder, cellForRow: indexPath, TableCell: cell)
	  }
	
	
	return cell
	}
	
	
	func updateValues(_ valueForPlaces:[Places],cellForRow indexPath: IndexPath, TableCell TVcell:FoodCVCell ){
		
		
		 // var returnVal = computeStatus(valueForPlaces[indexPath.row].openingTimeHour,closingtimeHour: valueForPlaces[indexPath.row].closingTimeHour,closingTimeMinute: valueForPlaces[indexPath.row].closingTimeMinute,openingTimeMinute: valueForPlaces[indexPath.row].openingTimeMinute)
		
		
		

		
		TVcell.foodPlaceImage.image = UIImage(named: "dinner-512")
		
		if(valueForPlaces[indexPath.row].placeFirstImageUrl != nil){
			
			
			TVcell.foodPlaceImage.kf.setImage(with: valueForPlaces[indexPath.row].placeFirstImageUrl)
		} else {
			print("Add the default image on places")
			TVcell.foodPlaceImage.image = UIImage(named: "dinnerPlace")
		}
		
	//	TVcell.foodPlaceStatus.text = computeStatus(valueForPlaces[indexPath.row].openingTimeHour,closingtimeHour: valueForPlaces[indexPath.row].closingTimeHour,closingTimeMinute: valueForPlaces[indexPath.row].closingTimeMinute,openingTimeMinute: valueForPlaces[indexPath.row].openingTimeMinute)
		


		
		
		TVcell.foodPlaceStatus.text = valueForPlaces[indexPath.row].statusEach
		
		TVcell.locationImg.image  = UIImage(named: "Location-1")

		TVcell.foodPlaceName.text = valueForPlaces[indexPath.row].placeName
		//TVcell.foodPlaceDistance.text = valueForPlaces[indexPath.row].placeDistance
		//TVcell.foodPlaceImage.image = valueForPlaces[indexPath.row].placeImage
		TVcell.foodPlaceRating.text = valueForPlaces[indexPath.row].placeRating
		TVcell.foodPlaceRating.text?.append("★")
		
		TVcell.foodPlaceDistance.text = computeDistance(valueForPlaces[indexPath.row].latFinal, longitude: valueForPlaces[indexPath.row].longFinal)
		
		

		
	}
	
	
	
	func computeDistance(_ lati: String,longitude longi: String)-> String{
		
		var distance: String!
		
		if let d = Float(lati) {
			if let e = Float(longi) {
				let coordinate1 = CLLocation(latitude: CLLocationDegrees(d),longitude: CLLocationDegrees(e))
				let coordinate2 = CLLocation(latitude: userLatitude,longitude: userLongitude)
				let distanceInMetres = coordinate1.distance(from: coordinate2)
				
				var V = Float(distanceInMetres)
				if(distanceInMetres <= 1000){
					
					distance = "\(V)"+" metres"
				}else {
					
					
					var vOne : Int!
					vOne = Int(V / 100)
					V = Float( vOne) / 10
					distance = "\(V)"+" KM"
				}
				
				
				
			}
		}

		
		
		
		return distance
	}
	
	
	override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
	//	let indexPathValues = collectionView.indexPathsForSelectedItems
		
		
		if(indexValueSecond == 0){
			
		    menuFoodId = restaurantOrder[indexPath.row].placeId
			if valueForSecondApiCall != indexPath.row {
				apiCallForMenu(menuFoodId,indexx: indexPath)
			}
			placeServiceStatusForPayment = Int(restaurantOrder[indexPath.row].service!)
			print("helloHappy \(placeServiceStatusForPayment!)")
			self.performSegue(withIdentifier: "shopmenu", sender: self)

			
			
		}
		else if(indexValueSecond == 1){
			menuFoodId = GroceriesOrder[indexPath.row].placeId
			if valueForSecondApiCall != indexPath.row {
				apiCallForMenu(menuFoodId,indexx: indexPath)
			}
			placeServiceStatusForPayment = Int(GroceriesOrder[indexPath.row].service!)
			print("helloHappy \(placeServiceStatusForPayment!)")
			self.performSegue(withIdentifier: "shopmenu", sender: self)

			
		}
		else if(indexValueSecond == 2){
			menuFoodId = MedicineOrder[indexPath.row].placeId
			if valueForSecondApiCall != indexPath.row {
				apiCallForMenu(menuFoodId,indexx: indexPath)
			}
			placeServiceStatusForPayment = Int(MedicineOrder[indexPath.row].service!)
			print("helloHappy \(placeServiceStatusForPayment!)")
			self.performSegue(withIdentifier: "shopmenu", sender: self)

			
		}
		else if(indexValueSecond == 3){
			menuFoodId = staitionaryOrder[indexPath.row].placeId
			if valueForSecondApiCall != indexPath.row {
				apiCallForMenu(menuFoodId,indexx: indexPath)
			}
			placeServiceStatusForPayment = Int(staitionaryOrder[indexPath.row].service!)
			print("helloHappy \(placeServiceStatusForPayment!)")
			self.performSegue(withIdentifier: "shopmenu", sender: self)

			
		}
		
//		if categoryOfItem.count != 0 {
//			self.performSegue(withIdentifier: "shopmenufirst", sender: self)
//		} else {
//			
//		}
		

	}
	
	
	
	
	
	
//	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
//	{
//		
//		
//		return CGSize(width: self.view.frame.width / 2, height: self.view.frame.height * 0.3)
//	}

	
	
	func apiCallForMenu(_ placeId: String,indexx path: IndexPath){
		
		// MARK:- api call for number of category
		
		
		
		var getMenuCategory = URLRequest(url: URL(string: "\(LEUK_URL)\(PHP_INDEX)method=getMenuCategory")!)
		getMenuCategory.httpMethod = "POST"
		let postValue11="key=\(UNIVERSAL_KEY)&secret=\(SECRET)&sessionid=\(SESSION_ID!)&token=\(TOKEN_ID_FROM_LEUK!)&place_id=\(placeId)"
		print("YSHSHSHSHSHS \(postValue11)")
		
		
		getMenuCategory.httpBody = postValue11.data(using: .utf8)
		
		let task = URLSession.shared.dataTask(with: getMenuCategory) { data, response, error in
			if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
				print("statusCode should be 200, but is \(httpStatus.statusCode)")
				//print("response = \(response)")
			}
				
			else {
				var json = JSON(data: data!)
				let numberOfItems = json["response"]["data"].count
				if numberOfItems > 0 {

					for index in 0...numberOfItems-1 {
						
						let value = json["response"]["data"][index]["category"].string!
						categoryOfItem.append(value)
				//MARK MARK
//						if categoryOfItem.count != 0 {
//							for cat in categoryOfItem {
//								if cat != value {
//									categoryOfItem.append(value)
//									//print(value)
//								}
//							}
//						}
//						else {
//							categoryOfItem.append(value)
//						}
						
						
					}
				
				
				
				}
		
			}
		}
		task.resume()
		
		
		
		
		// MARK: - placeid
		
		
		
		
		
		
		
		
		commonForShop.removeAll()

		
		
		// MARK:- Api call for next page
		
//		var getMenu = URLRequest(url: URL(string: "\(LEUK_URL)\(PHP_INDEX)method=getMenu")!)
//		getMenu.httpMethod = "POST"
//		let postValue="key=\(UNIVERSAL_KEY)&secret=\(SECRET)&sessionid=\(SESSION_ID)&token=\(TOKEN_ID_FROM_LEUK)&place_id=\(placeId)"
//		print("YSHSHSHSHSHS \(postValue)")
//		
//		
//		getMenu.httpBody = postValue.data(using: .utf8)
//		
//		let task2 = URLSession.shared.dataTask(with: getMenu) { data, response, error in
//			if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
//				print("statusCode should be 200, but is \(httpStatus.statusCode)")
//				//print("response = \(response)")
//			}
//				
//			else {
//				
//				
//				var json = JSON(data: data!)
//				print("yuvraj lakj \(json)")
//				let numberOfItems = json["response"]["data"].count
//				print(numberOfItems)
//				if numberOfItems > 0
//				{
//					
//					for index in 0...numberOfItems-1 {
//						let menuList = shopMenuItem()
//						menuList.itemId = json["response"]["data"][index]["id"].string!
//						menuList.itemNonVeg = json["response"]["data"][index]["non_veg"].string!
//						menuList.itemOfferCost = json["response"]["data"][index]["offer_cost"].string!
//						menuList.itemCategory = json["response"]["data"][index]["category"].string!
//						menuList.itemDescription = json["response"]["data"][index]["description"].string!
//						menuList.itemName = json["response"]["data"][index]["item_name"].string!
//						menuList.itemLimit = json["response"]["data"][index]["item_limit"].string!
//						menuList.itemVeg = json["response"]["data"][index]["veg"].string!
//						menuList.itemtags = json["response"]["data"][index]["tags"].string!
//						menuList.itemspicy = json["response"]["data"][index]["spicy"].string!
//						menuList.itemLove = json["response"]["data"][index]["love"].string!
//						menuList.itemImageLink = json["response"]["data"][index]["image"].string!
//						menuList.itemPlaceId = json["response"]["data"][index]["place_id"].string!
//						menuList.itemRegularCost = json["response"]["data"][index]["regular_cost"].string!
//			
//					
//						
//						commonForShop.append(menuList)
//						
////					
////						if(menuList.itemCategory != nil){
////					
////						
////						if(self.indexValueSecond == 0){
////							
////							foodForShop.append(menuList)
////							//print(menuList.itemCategory)
////							
//////							for value in foodForShop {
//////								if value.itemCategory != menuList.itemCategory {
//////									self.categoryOfItem.append(menuList.itemCategory)
//////									//print(menuList.itemCategory)
//////									
//////								}
//////							}
////							
////						}
////						else if(self.indexValueSecond == 1){
////							groceriesForShop.append(menuList)
////						}
////						else if(self.indexValueSecond == 2){
////							medicineForShop.append(menuList)
////							
////							
////							
////						}
////						else if(self.indexValueSecond == 3){
////							stationaryForShop.append(menuList)
////							
////						}
////						}
////				
//					
//					}
//				}
//				
//			
//			
//			}
//		}
//		
//		task2.resume()
		self.valueForSecondApiCall = path.row
		
	}

	
	override func viewDidAppear(_ animated: Bool) {
		categoryOfItem.removeAll()
		cartValues.removeAll()
		
		
		getStatusOfPlaces()
		
		


	}
	
	
	func getStatusOfPlaces(){
		if(indexValueSecond == 0){
			updateValueForPlace(restaurantOrder)
		}
		else if(indexValueSecond == 1){
			updateValueForPlace(GroceriesOrder)
		}
		else if(indexValueSecond == 2){
			updateValueForPlace(MedicineOrder)
		}
		else if(indexValueSecond == 3){
			updateValueForPlace(staitionaryOrder)
		}
		self.collectionView?.reloadData()
	}
	
	
	
	func updateValueForPlace(_ objcts : [Places]){
		
		for objct in objcts {
			objct.statusEach = computeStatus(objct.openingTimeHour, closingtimeHour: objct.closingTimeHour, closingTimeMinute: objct.closingTimeMinute, openingTimeMinute: objct.openingTimeMinute)
		}
		
		
	}
	
	func computeStatus(_ openingTimeHour: String,closingtimeHour closingTimeHour: String,closingTimeMinute: String,openingTimeMinute: String) -> String{
		
		
		
		
		print(openingTimeHour)
		print(closingTimeHour)
		print(openingTimeMinute)
		print(closingTimeMinute)
		
		
		
		let date = Date()
		
		let calender = Calendar.current
		let hour = calender.component(.hour, from: date)
		print("haps")
		print(hour)
		statusLocal = "OPEN NOW"
		
		
		if Int(openingTimeHour)! < Int(closingTimeHour)!{
			
			if hour >= Int(openingTimeHour)! && hour < Int(closingTimeHour)! {
				
				statusLocal = "OPEN NOW"
			}else{
				statusLocal = "ClOSED"
			}
			if hour == Int(closingTimeHour)! - 1{
				
				statusLocal = "CLOSING NOW"
			}
			
		}else{
//			let close = Int(closingTimeHour)! + 24
//			if hour < Int(closingTimeHour)!{
				//hour = hour + 24
				if hour > Int(openingTimeHour)! || hour < Int(closingTimeHour)!{
					statusLocal = "OPEN NOW"
				}else{
					statusLocal = "CLOSED"
				}
				if hour == Int(closingTimeHour)! - 1{
					statusLocal = "CLOSING NOW"
				}
			//}
			
			
			
		}
		
		
		
		return statusLocal
		
	}
	

	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

		
		
		
			if segue.identifier == "shopmenu" {
			let shopMenuVC = segue.destination as! ShopMenu 
				
			
			if self.indexValueSecond == 0 {
				shopMenuVC.indexValueShop = 0
				shopMenuVC.menuFoodId = menuFoodId
				
			} else if self.indexValueSecond == 1 {
				shopMenuVC.indexValueShop = 1
				shopMenuVC.menuFoodId = menuFoodId

				
			} else if self.indexValueSecond == 2 {
				shopMenuVC.indexValueShop = 2
				shopMenuVC.menuFoodId = menuFoodId

				
			} else {
				shopMenuVC.indexValueShop = 3
				shopMenuVC.menuFoodId = menuFoodId

				
			}
		}
	}
	
	
	
	
	
	

}
