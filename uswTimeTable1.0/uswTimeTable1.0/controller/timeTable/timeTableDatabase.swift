//
//  timeTableDatabase.swift
//  uswTimeTable1.0
//
//  Created by 한지석 on 2022/01/06.
//

import Foundation 
import Accessibility
import UIKit
import RealmSwift

class CourseData: Object{
   
    @objc dynamic var courseName: String = ""
    @objc dynamic var roomName: String = ""
    @objc dynamic var professor: String = ""
    @objc dynamic var classification: String = ""
    @objc dynamic var courseDay: String = ""
    @objc dynamic var startTime: String = ""
    @objc dynamic var endTime: String = ""
    @objc dynamic var major: String = ""
    @objc dynamic var credit: Int = 0
    @objc dynamic var num: Int = 0
    @objc dynamic var classNum: String = ""


}

class UserCourse: Object{
    
    @objc dynamic var courseId: String = ""
    @objc dynamic var courseName: String = ""
    @objc dynamic var roomName: String = ""
    @objc dynamic var professor: String = ""
    @objc dynamic var courseDay: Int = 0
    @objc dynamic var startTime: String = ""
    @objc dynamic var endTime: String = ""
    
    @objc dynamic var courseCount: Int = 0

}

class userDB: Object{
    @objc dynamic var tableCnt: Int = 0
    @objc dynamic var year: String = ""
    @objc dynamic var semester: String = ""
    @objc dynamic var timetableName: String = ""
    let userCourseData = List<UserCourse>()
}


