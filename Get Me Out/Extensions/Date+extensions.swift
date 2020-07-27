//
//  Date+extensions.swift
//  Get Me Out
//
//  Created by Salah  on 31/05/2020.
//  Copyright © 2020 Salah . All rights reserved.
//

import Foundation

extension Date{
    
    func getYearMonthDayHourMinute()-> DateComponent{
        let calender = Calendar.current
        let month = calender.component(.month, from: self)
        let day = calender.component(.day, from: self)
        let hour = calender.component(.hour, from: self)
        let minute = calender.component(.minute, from: self)
        
        
        let dateComponent = DateComponent(month: month, day: day, hour: hour, minute: minute)
        return dateComponent
        
        
    }
    
    
    
}
