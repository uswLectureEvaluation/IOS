//
//  lectureDetailedInformationPage.swift
//  uswTimeTable1.0
//
//  Created by 한지석 on 2022/04/04.
//

import UIKit
import KeychainSwift
import Alamofire
import SwiftyJSON

class lectureDetailedInformationPage: UIViewController {

    let keychain = KeychainSwift()
    var lectureId = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDetailPage()
        // Do any additional setup after loading the view.
    }
    
    func getDetailPage(){
        let url = "https://api.suwiki.kr/lecture/?lectureId=\(lectureId)"
        
 
        let headers: HTTPHeaders = [
            "AccessToken" : String(keychain.get("AccessToken") ?? "")
        ]
  
        
        print(url)
        print(keychain.get("AccessToken"))
              //

        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            
            let data = response.value
            
            let json = JSON(data)
            
            print(json.count)
            print(json)
        }
        
        
    }

}
