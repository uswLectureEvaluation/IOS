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

// 1. 화면이 켜질 때 eval / exam 데이터 리스트에 저장
// 2. 데이터는 10개씩만 테이블 뷰에 보여주고, 이후 스크롤 시 이후 데이터 마저 불러오기
// 3. 강의평가 -> 시험평가 버튼 클릭 시 메인 리스트 비우고, reloadData 진행

class lectureDetailedInformationPage: UIViewController {

    @IBOutlet weak var lectureView: UIView!
    @IBOutlet weak var lectureName: UILabel!
    @IBOutlet weak var professor: UILabel!
    
    @IBOutlet weak var lectureHoneyAvg: UILabel!
    @IBOutlet weak var lectureLearningAvg: UILabel!
    @IBOutlet weak var lectureSatisAvg: UILabel!
  
    var detailViewArray: Array<Any> = []
    var detailLectureArray: Array<detailLecture> = []
    var detailEvaluationArray: Array<detailEvaluation> = []
    
    var lectureId = 0
    let keychain = KeychainSwift()
    
    override func viewDidLoad() {
        lectureView.layer.borderWidth = 1.0
        lectureView.layer.borderColor = UIColor.lightGray.cgColor
        lectureView.layer.cornerRadius = 12.0
        super.viewDidLoad()
        getDetailPage()
        getDetailEvaluation()
        

    }
    
    func lectureViewUpdate(){
        lectureName.text = detailLectureArray[0].lectureName
        lectureName.sizeToFit()
        professor.text = detailLectureArray[0].professor
        professor.sizeToFit()
        lectureHoneyAvg.text = detailLectureArray[0].lectureHoneyAvg
        lectureLearningAvg.text = detailLectureArray[0].lectureLearningAvg
        lectureSatisAvg.text = detailLectureArray[0].lectureSatisfactionAvg

    }
    
    func getDetailPage(){
        let url = "https://api.suwiki.kr/lecture/?lectureId=\(lectureId)"
        
        let headers: HTTPHeaders = [
            "Authorization" : String(keychain.get("AccessToken") ?? "")
        ]

            
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            
            let data = response.value
            
            let json = JSON(data!)["data"]
            print(json)
            let totalAvg = String(format: "%.1f", round(json["lectureTotalAvg"].floatValue * 1000) / 1000)
            let totalSatisfactionAvg = String(format: "%.1f", round(json["lectureSatisfactionAvg"].floatValue * 1000) / 1000)
            let totalHoneyAvg = String(format: "%.1f", round(json["lectureHoneyAvg"].floatValue * 1000) / 1000)
            let totalLearningAvg = String(format: "%.1f", round(json["lectureLearningAvg"].floatValue * 1000) / 1000)
            
            let detailLectureData = detailLecture(id: json["id"].intValue, semester: json["semester"].stringValue, professor: json["professor"].stringValue, lectureType: json["lectureType"].stringValue, lectureName: json["lectureName"].stringValue, lectureTotalAvg: totalAvg, lectureSatisfactionAvg: totalSatisfactionAvg, lectureHoneyAvg: totalHoneyAvg, lectureLearningAvg: totalLearningAvg, lectureTeamAvg: json["lectureTeamAvg"].floatValue, lectureDifficultyAvg: json["lectureDifficultyAvg"].floatValue, lectureHomeworkAvg: json["lectureHomeworkAvg"].floatValue)

            self.detailLectureArray.append(detailLectureData)
            self.lectureViewUpdate()
            
        }
        
        
    }

    func getDetailEvaluation(){
        let url = "https://api.suwiki.kr/evaluate-posts/findByLectureId/?lectureId=\(lectureId)"
        
        let headers: HTTPHeaders = [
            "Authorization" : String(keychain.get("AccessToken") ?? "")
        ]
        
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            let data = response.value
            let json = JSON(data!)
    
            print(json["data"].count) // 해당 데이터 갯수 나옴
            for index in 0..<json["data"].count{
                let jsonData = json["data"][index]
                var team = ""
                var difficulty = ""
                var homework = ""
                let totalAvg = String(format: "%.1f", round(jsonData["totalAvg"].floatValue * 1000) / 1000)
                let satisfaction = String(format: "%.1f", round(jsonData["satisfaction"].floatValue * 1000) / 1000)
                let learning = String(format: "%.1f", round(jsonData["learning"].floatValue * 1000) / 1000)
                let honey = String(format: "%.1f", round(jsonData["honey"].floatValue * 1000) / 1000)
                
                if jsonData["team"] == 0 {
                    team = "없음"
                } else if jsonData["team"] == 1 {
                    team = "있음"
                }
                
                if jsonData["difficulty"] == 0{
                    difficulty = "까다로움"
                } else if jsonData["difficulty"] == 1 {
                    difficulty = "보통"
                } else if jsonData["difficulty"] == 2 {
                    difficulty = "개꿀"
                }
                
                if jsonData["homework"] == 0 {
                    homework = "없음"
                } else if jsonData["homework"] == 1{
                    homework = "보통"
                } else if jsonData["homework"] == 2 {
                    homework = "많음"
                }
                
                let readData = detailEvaluation(id: jsonData["id"].intValue, semester: jsonData["semester"].stringValue, totalAvg: totalAvg, satisfaction: satisfaction, learning: learning, honey: honey, team: team, difficulty: difficulty, homework: homework, content: jsonData["content"].stringValue)
                
                self.detailEvaluationArray.append(readData)
                
            }
            print(self.detailEvaluationArray)
        }
    }
    
    func getDetailExam(){
        
        
    }
}

class detailEvalAndExamCell: UITableViewCell{
    
}
