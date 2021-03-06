//
//  courseData.swift
//  uswTimeTable1.0
//
//  Created by 한지석 on 2022/02/21.
//

import Foundation

class Course: Codable{
    let courseName: String
    let roomName: String
    let professor: String
    let major: String
    let classification: String 
    let courseDay: String
    let startTime: String
    let endTime: String
    let num: Int
    
    init(courseName: String, roomName: String, professor: String, major: String, classification: String, courseDay: String, startTime: String, endTime: String, num: Int){
        self.courseName = courseName
        self.roomName = roomName
        self.professor = professor
        self.major = major
        self.classification = classification
        self.courseDay = courseDay
        self.startTime = startTime
        self.endTime = endTime
        self.num = num
    }
}
class externalData: Codable{
    let classNum: String
    let classfication: String
    let courseDay: String
    let courseName: String
    let credit: Int
    let endTime: String
    let major: String
    let num: Int
    let professor: String
    let roomName: String
    let startTime: String
    
    init(classNum: String, classification: String, courseDay: String, courseName: String, credit: Int, endTime: String, major: String, num: Int, professor: String, roomName: String, startTime: String) {
        
        self.classNum = classNum
        self.classfication = classification
        self.courseDay = courseDay
        self.courseName = courseName
        self.credit = credit
        self.endTime = endTime
        self.major = major
        self.num = num
        self.professor = professor
        self.roomName = roomName
        self.startTime = startTime
        
    }
}

class userTable: Codable{
    let year: String
    let semester: String
    let timetableName: String
    
    init(year: String, semester: String, timetableName: String){
        self.year = year
        self.semester = semester
        self.timetableName = timetableName
    }
}
/*
 startTime.append(readST)
 endTime.append(readET)
 courseName.append(readCN)
 roomName.append(readRN)
 professor.append(readPR)
 major.append(readMJ)
 classification.append(readCF)
 num.append(readNM)
 courseDay.append(readCD)
 
 init(UserNum:String, UserName:String, UserAge:Int, UserAd:Bool) {
         self.UserNum = UserNum
         self.UserName = UserName
         self.UserAge = UserAge
         self.UserAd = UserAd
     }
 */
