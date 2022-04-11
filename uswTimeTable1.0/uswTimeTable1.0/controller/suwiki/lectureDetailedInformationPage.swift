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
// 테이블뷰넘버로 시험정보 구매 여부 확인 후 넘버 변경 -> 시험 정보 출력

class lectureDetailedInformationPage: UIViewController, UITableViewDelegate, UITableViewDataSource {

    

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lectureView: UIView!
    @IBOutlet weak var lectureName: UILabel!
    @IBOutlet weak var professor: UILabel!
    
    @IBOutlet weak var teamView: UILabel!
    @IBOutlet weak var homeworkView: UILabel!
    @IBOutlet weak var pointView: UILabel!
    
    @IBOutlet weak var lectureHoneyAvg: UILabel!
    @IBOutlet weak var lectureLearningAvg: UILabel!
    @IBOutlet weak var lectureSatisAvg: UILabel!
  
    @IBOutlet weak var evaluationBtn: UIButton!
    @IBOutlet weak var examBtn: UIButton!
    
    var detailViewArray: Array<Any> = []
    var detailLectureArray: Array<detailLecture> = []
    var detailEvaluationArray: Array<detailEvaluation> = []
    var detailExamArray: Array<detailExam> = []
    
    var testArray = ["1", "2", "3", "4", "5"]
    var testArray1 = ["1", "2", "3"]
    
    var lectureId = 0
    let keychain = KeychainSwift()
    

    var tableViewNumber = 0
    
    override func viewDidLoad() {
        loadDetailData()
        lectureView.layer.borderWidth = 1.0
        lectureView.layer.borderColor = UIColor.lightGray.cgColor
        lectureView.layer.cornerRadius = 12.0
        super.viewDidLoad()
        getDetailPage()
        print(lectureId)
        evaluationBtn.tintColor = .darkGray
        
        let evaluationCellName = UINib(nibName: "detailEvaluationCell", bundle: nil)
        tableView.register(evaluationCellName, forCellReuseIdentifier: "evaluationCell")
        let examCellName = UINib(nibName: "detailExamCell", bundle: nil)
        tableView.register(examCellName, forCellReuseIdentifier: "examCell")
        
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 120
        self.tableView.reloadData()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
    }
    
    @IBAction func evaluationBtnClicked(_ sender: Any) {
        tableViewNumber = 0
        evaluationBtn.tintColor = .darkGray
        examBtn.tintColor = .lightGray
        tableView.reloadData()
        
    }
    
    @IBAction func examBtnClicked(_ sender: Any) {
        tableViewNumber = 2
        examBtn.tintColor = .darkGray
        evaluationBtn.tintColor = .lightGray
        tableView.reloadData()
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableViewNumber == 0 {
            return self.detailEvaluationArray.count
        } else {
            return self.detailExamArray.count
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableViewNumber == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "evaluationCell", for: indexPath) as! detailEvaluationCell
            
            cell.content.numberOfLines = 0
            
            cell.semester.text = detailEvaluationArray[indexPath.row].semester
            cell.totalAvg.text = detailEvaluationArray[indexPath.row].totalAvg
            cell.satisfactionPoint.text = detailEvaluationArray[indexPath.row].satisfaction
            cell.honeyPoint.text = detailEvaluationArray[indexPath.row].honey
            cell.learningPoint.text = detailEvaluationArray[indexPath.row].learning
            cell.team.text = detailEvaluationArray[indexPath.row].team
            cell.homework.text = detailEvaluationArray[indexPath.row].homework
            cell.difficulty.text = detailEvaluationArray[indexPath.row].difficulty
            cell.content.text = detailEvaluationArray[indexPath.row].content
            
            return cell
            
        } else if tableViewNumber == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "examCell", for: indexPath) as! detailExamCell
            
            cell.examType.text = detailExamArray[indexPath.row].examType
            cell.examDifficulty.text = detailExamArray[indexPath.row].examDifficulty
            cell.content.text = detailExamArray[indexPath.row].content
            
            return cell
        }
        return UITableViewCell()
           
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
      
            let totalAvg = String(format: "%.1f", round(json["lectureTotalAvg"].floatValue * 1000) / 1000)
            let totalSatisfactionAvg = String(format: "%.1f", round(json["lectureSatisfactionAvg"].floatValue * 1000) / 1000)
            let totalHoneyAvg = String(format: "%.1f", round(json["lectureHoneyAvg"].floatValue * 1000) / 1000)
            let totalLearningAvg = String(format: "%.1f", round(json["lectureLearningAvg"].floatValue * 1000) / 1000)
            
            let detailLectureData = detailLecture(id: json["id"].intValue, semester: json["semester"].stringValue, professor: json["professor"].stringValue, lectureType: json["lectureType"].stringValue, lectureName: json["lectureName"].stringValue, lectureTotalAvg: totalAvg, lectureSatisfactionAvg: totalSatisfactionAvg, lectureHoneyAvg: totalHoneyAvg, lectureLearningAvg: totalLearningAvg, lectureTeamAvg: json["lectureTeamAvg"].floatValue, lectureDifficultyAvg: json["lectureDifficultyAvg"].floatValue, lectureHomeworkAvg: json["lectureHomeworkAvg"].floatValue)

            self.detailLectureArray.append(detailLectureData)
            self.lectureViewUpdate()
            
        }
        
        
    }

    func loadDetailData(){
        DispatchQueue.global().async {
            self.getDetailEvaluation()
            self.getDetailExam()
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
            self.tableView.reloadData()
            print(self.detailEvaluationArray)
        }
    }
    
    func getDetailExam(){
        let url = "https://api.suwiki.kr/exam-posts/findByLectureId/?lectureId=\(lectureId)"
        
        let headers: HTTPHeaders = [
            "Authorization" : String(keychain.get("AccessToken") ?? "")
        ]
        
        
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            let data = response.value
            let json = JSON(data!)
            print(json)
            for index in 0..<json["data"].count{
                let jsonData = json["data"][index]
                
                let readData = detailExam(id: jsonData["id"].intValue, semester: jsonData["semester"].stringValue, examInfo: jsonData["examInfo"].stringValue, examType: jsonData["examType"].stringValue, examDifficulty: jsonData["examDifficulty"].stringValue, content: jsonData["content"].stringValue)
                
                self.detailExamArray.append(readData)
            }
            print(self.detailExamArray)
        }
    }
}

