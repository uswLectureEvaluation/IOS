//
//  adjustCourseData.swift
//  uswTimeTable1.0
//
//  Created by 한지석 on 2022/03/03.
//

import UIKit
import DropDown

class adjustCourseData: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var startView: UIView!
    @IBOutlet weak var endView: UIView!
    @IBOutlet weak var startTextField: UILabel!
    @IBOutlet weak var endTextField: UILabel!
    @IBOutlet weak var roomTextField: UITextField!
    
    @IBOutlet weak var courseNameField: UILabel!
    @IBOutlet weak var professorField: UILabel!
    @IBOutlet weak var roomNameField: UILabel!
    @IBOutlet weak var majorField: UILabel!
    
    let startDropDown = DropDown()
    let endDropDown = DropDown()
    
    let startTimeList = ["09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21"]
    let endTimeList = ["10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22"]
    
    var roomNameData = ""
    var courseNameData = ""
    var professorData = ""
    var courseDayData = ""
    var numData = 0
    var classificationData = ""
    var startTimeData = ""
    var endTimeData = ""
    
    var checkAdjust = 0
    var deleteIndex = 0
    
    //     var startTimeData = "" var endTimeData = ""     var roomNameData = ""

    
    override func viewDidLoad() {
        roomTextField.delegate = self
        courseNameField.text = courseNameData
        roomNameField.text = roomNameData
        professorField.text = professorData
        majorField.text = classificationData
        print(courseNameData)
        print(roomNameData)
        print(professorData)
        super.viewDidLoad()
        
        roomTextField.text = roomNameData 
        startDropDown.anchorView = startView
        startDropDown.dataSource = startTimeList
        startDropDown.bottomOffset = CGPoint(x: 0, y:(startDropDown.anchorView?.plainView.bounds.height)!)
        startDropDown.direction = .bottom
        startDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)")
            self.startTextField.text = startTimeList[index] 
            self.startTextField.font = UIFont(name: "system", size: 13)
            self.startTextField.textColor = .black
            self.startTextField.textAlignment = .center
            print("\(String(describing: startTextField.text!)):30")
                                            
        }
        
        endDropDown.anchorView = endView
        endDropDown.dataSource = endTimeList
        endDropDown.bottomOffset = CGPoint(x: 0, y:(endDropDown.anchorView?.plainView.bounds.height)!)
        endDropDown.direction = .bottom
        endDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)")
            self.endTextField.text = endTimeList[index]
            self.endTextField.font = UIFont(name: "system", size: 13)
            self.endTextField.textColor = .black
            self.endTextField.textAlignment = .center
                                            
        }

        navigationBarHidden()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func startBtnClicked(_ sender: Any) {
        startDropDown.show()
    }
    @IBAction func endBtnClicked(_ sender: Any) {
        endDropDown.show()

    }
    
    @IBAction func finishBtnClicked(_ sender: Any) {
       
        if roomTextField.text == "" || startTextField.text == "시작" || endTextField.text == "종료" {
            showAlert(title: "비어있는 데이터가 있어요")
            //4. 경고창 보이기
        } else if checkAdjust == 0{

            
            let AD = UIApplication.shared.delegate as? AppDelegate

            //  let infoVC = self.storyboard?.instantiateViewController(withIdentifier: "infoVC") as! infoCourseData
            AD?.roomName = roomTextField.text ?? ""
            AD?.startTime = "\(String(describing: startTextField.text!)):30"
            AD?.endTime = "\(String(describing: endTextField.text!)):20"
          //  let infoVC = self.storyboard?.instantiateViewController(withIdentifier: "infoVC") as! infoCourseData
            
            self.dismiss(animated: true, completion: nil)
        } else if checkAdjust == 1{
            
            let AD = UIApplication.shared.delegate as? AppDelegate

            //  let infoVC = self.storyboard?.instantiateViewController(withIdentifier: "infoVC") as! infoCourseData
            AD?.roomName = roomTextField.text ?? ""
            AD?.startTime = "\(String(describing: startTextField.text!)):30"
            AD?.endTime = "\(String(describing: endTextField.text!)):20"
          //  let infoVC = self.storyboard?.instantiateViewController(withIdentifier: "infoVC") as! infoCourseData
            
            self.dismiss(animated: true, completion: nil)
        }
        
        
        // 취소버튼 누를땐 원본 그대로 다시 보내주기
    /*
        infoVC.courseNameData = filteredUswCourse[indexPath.row].courseName
        infoVC.roomNameData = filteredUswCourse[indexPath.row].roomName
        infoVC.professorData = filteredUswCourse[indexPath.row].professor
        infoVC.numData = filteredUswCourse[indexPath.row].num
        infoVC.courseDayData = filteredUswCourse[indexPath.row].courseDay
        infoVC.startTimeData = filteredUswCourse[indexPath.row].startTime
        infoVC.endTimeData = filteredUswCourse[indexPath.row].endTime
        infoVC.classificationData = filteredUswCourse[indexPath.row].classification
        infoVC.checkTimeTable = self.checkTimeTable
        */
        
    }
    // 변경 허용한 정보 1. 장소 2. startTime & endTime
    // if 완료 안누를 시 데이터 삭제 x, 완료 누르면 데이터 삭제하는 로직 필요. readCourse하는 로직이 infoCourseData랑 비슷.(--> 그냥 infoCourseData로 넘겨도 될듯)
    
    @IBAction func cancelBtnClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        /*
        let infoVC = self.storyboard?.instantiateViewController(withIdentifier: "infoVC") as! infoCourseData
        infoVC.roomNameData = roomTextField.text ?? ""
        infoVC.startTimeData = startTimeData
        infoVC.endTimeData = endTimeData
        infoVC.professorData = professorData
        infoVC.courseNameData = courseNameData
        infoVC.courseDayData = courseDayData
        infoVC.classificationData = classificationData
        infoVC.numData = numData
        print("\(startTimeData)")
        print("\(endTimeData)")
        self.navigationController?.pushViewController(infoVC, animated: true)
         */
    }
    
    
    func showAlert(title: String) {
        let alert = UIAlertController(title: title, message: "확인 버튼을 눌러주세요!", preferredStyle: UIAlertController.Style.alert)
        let cancle = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(cancle)
        present(alert,animated: true,completion: nil)
    }
    
    
    
    func navigationBarHidden() {
            self.navigationController?.navigationBar.isHidden = true
        }
    
    func navigationBackSwipeMotion() {
           self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
       }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    
        let maxLength = 12
        let currentString: NSString = (roomTextField.text ?? "") as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
         
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){

          self.view.endEditing(true)

    }
}
