//
//  ProfileVC.swift
//  Leuk_iOS
//
//  Created by yuvraj singh on 13/04/17.
//  Copyright © 2017 yuvi0049. All rights reserved.
//

import UIKit
import PagingMenuController
import SwiftyJSON

private struct PagingMenuOptions: PagingMenuControllerCustomizable {
	let viewController2 = TicketsVC.instantiateFromStoryboard()
	
	private let viewController1 = OrderVC.instantiateFromStoryboard()
	let viewController3 = CouponsVC.instantiateFromStoryboard()
	fileprivate var componentType: ComponentType {
		return .all(menuOptions: MenuOptions(), pagingControllers: pagingControllers)
	}
	
	fileprivate var pagingControllers: [UIViewController] {
		return [viewController1, viewController2,viewController3]
	}
	
	fileprivate struct MenuOptions: MenuViewCustomizable {
		fileprivate var backgroundColor: UIColor = UIColor.leukRed()//(netHex: 0xEC5E5E)
		
		var focusMode: MenuFocusMode{
			return .roundRect(radius: CGFloat(20), horizontalPadding: 2, verticalPadding: 7, selectedColor: UIColor.blue)//netHex: 0xC95153))
		}
		var displayMode: MenuDisplayMode {
			return .segmentedControl
		}
		var itemsOptions: [MenuItemViewCustomizable] {
			return [MenuItem1(), MenuItem2(), MenuItem3()]
		}
		
		
		
	}
	
	/*public enum MenuFocusMode {
	case none
	case underline(height: , color: UIColor.red, horizontalPadding: 2, verticalPadding: 2)
	case roundRect(radius: 50, horizontalPadding: CGFloat, verticalPadding: CGFloat, selectedColor: UIColor)
	}*/
	fileprivate struct MenuItem1: MenuItemViewCustomizable {
		
		var displayMode: MenuItemDisplayMode {
			return .text(title: MenuItemText(text: "Orders", color: UIColor.white, selectedColor:UIColor.white, font: UIFont.systemFont(ofSize: 13), selectedFont: UIFont.systemFont(ofSize: 13)))
		}
	}
	fileprivate struct MenuItem2: MenuItemViewCustomizable {
		var displayMode: MenuItemDisplayMode {
			return .text(title: MenuItemText(text: "Tickets", color: UIColor.white, selectedColor:UIColor.white, font: UIFont.systemFont(ofSize: 13), selectedFont: UIFont.systemFont(ofSize: 13)))
		}
	}
	
	fileprivate struct MenuItem3: MenuItemViewCustomizable {
		var displayMode: MenuItemDisplayMode {
			return .text(title: MenuItemText(text: "Coupons", color: UIColor.white, selectedColor:UIColor.white, font: UIFont.systemFont(ofSize: 13), selectedFont: UIFont.systemFont(ofSize: 13)))        }
	}
}

class ProfileVC: UIViewController {
	
	
	
	
	
	var indexValue = 1
	
	@IBOutlet weak var btnToHomeOutlet: UIButton!
	@IBAction func btnToHome(_ sender: Any) {
		

		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let controller = storyboard.instantiateViewController(withIdentifier: "launchdone1")
		self.present(controller, animated: true, completion: nil)
	}
	
	
	@IBOutlet weak var smallView: UIView!
	@IBOutlet weak var profileImg: UIImageView!
	@IBOutlet weak var customerName: UILabel!
	@IBOutlet weak var customerArea: UILabel!
	@IBOutlet weak var customerRefCode: UILabel!
	@IBOutlet weak var customerLevel: UILabel!
	@IBOutlet weak var custCreditsLeft: UILabel!
	@IBOutlet weak var nextLabel: UILabel!
	
	
	var options: PagingMenuControllerCustomizable!
	
	
    override func viewDidLoad() {
        super.viewDidLoad()
	 self.title = "MY PROFILE"
	
	print("Your PROFILE here")

	//getUserDetails()
	
	
	//profileApi()
	
	
	if (Name == nil){
		profileApi()

	}else {
		profileUpdate()
	}
	

	if(indexValue == 1) {
	btnToHomeOutlet.isHidden = true
	
	}
	else if(indexValue == 2) {
		btnToHomeOutlet.isHidden = false
	}
	
	
	profileImg.backgroundColor = UIColor.leukRed()
	profileImg.layer.cornerRadius = 8.0
	profileImg.clipsToBounds = true

	
	
	pagingCall()
	
	
	
	
    }
	
	
	func profileUpdate(){
		
		
		fetchImage()
		customerName.text = Name
		customerArea.text = area
		customerRefCode.text = referalCode
		customerLevel.text = level
		let next = Int(level!)
		nextLabel.text = "\(next! + 1)"
		custCreditsLeft.text = "\(remainingCredits!) credits left"

	}
	
	
	
	func profileApi(){
		
		
		//MARK:- PROFILE
		
		var profileRequest = URLRequest(url: URL(string: "\(LEUK_URL)\(PHP_INDEX)method=getUserInfo")!)
		profileRequest.httpMethod = "POST"
		let postString1="key=\(UNIVERSAL_KEY)&secret=\(SECRET)&sessionid=\(SESSION_ID!)&token=\(TOKEN_ID_FROM_LEUK!)"
		print("\(postString1)")
		
		
		profileRequest.httpBody = postString1.data(using: .utf8)
		
		let task2 = URLSession.shared.dataTask(with: profileRequest) { data, response, error in
			if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
				print("statusCode should be 200, but is \(httpStatus.statusCode)")
				//print("response = \(response)")
			}
				
			else {
				//print("RFcss")
				//let responseString = String(data: data!, encoding: .utf8)
				//print("responseString = \(responseString!)")
				
				
				
				
				
				var json = JSON(data: data!)
				Name = json["response"]["data"]["name"].string!
				area = json["response"]["data"]["location"].string!
				referalCode = json["response"]["data"]["referral_code"].string!
				level = json["response"]["data"]["level"].string!
				profileImages = json["response"]["data"]["profile_img"].string!
				totalCredits = json["response"]["data"]["total_credits"].string!
				remainingCredits = json["response"]["data"]["remaining_credits"].string!
				self.profileUpdate()
			}
			
		}
		
		task2.resume()
		
		
	}

	
	
	
	
	
	
	
	
	
	
	private func fetchImage() {
		
		
		let url = URL(string: profileImages)
		profileImg.kf.setImage(with: url)
		

	}

	
	
	
	
	
	
	
	func pagingCall(){
		
		let options = PagingMenuOptions()
		let pagingMenuController = PagingMenuController(options: options)
		pagingMenuController.view.frame.origin.y += 0
		pagingMenuController.view.frame.size.height -= 64
		pagingMenuController.onMove = { state in
			switch state {
			case let .willMoveController(menuController, previousMenuController):
				print(previousMenuController)
				print(menuController)
			case let .didMoveController(menuController, previousMenuController):
				print(previousMenuController)
				print(menuController)
			case let .willMoveItem(menuItemView, previousMenuItemView):
				print(previousMenuItemView)
				print(menuItemView)
			case let .didMoveItem(menuItemView, previousMenuItemView):
				print(previousMenuItemView)
				print(menuItemView)
				//  case .didScrollStart:
				print("Scroll start")
				//case .didScrollEnd:
				print("Scroll end")
			default : print("Default case")
				
				
			}
		}
		
		addChildViewController(pagingMenuController)
		smallView.addSubview(pagingMenuController.view)
		pagingMenuController.didMove(toParentViewController: self)

	}
	
	
	

	

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
