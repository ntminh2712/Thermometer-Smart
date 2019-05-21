
//
//  Date+Extension.swift
//  BaseSwift
//
//  Created by nava on 7/13/18.
//  Copyright © 2018 nava. All rights reserved.
//

import Foundation

extension Date {
    func convertDateToStringWithDateFormat(dateFormat: String) -> String? {
        let dateFormater = DateFormatter()
        dateFormater.locale = Locale(identifier: "en_US_POSIX")
        dateFormater.timeZone = TimeZone.current
        dateFormater.dateFormat = dateFormat
        return dateFormater.string(from: self)
    }
    
    func toString(withFormat dateFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: self)
    }
    
    func isBetween(from date1:Date, to date2:Date) -> Bool{
        return date1.compare(self) == self.compare(date2)
    }
    
    func daysBetween(_ anotherDate: Date) -> Int {
        let time: TimeInterval = self.timeIntervalSince(anotherDate)
        return Int(abs(time / 60 / 60 / 24)) + 1
    }
    
    static func timeAgoSinceDate(date: Date, currentDate: Date) -> String {
        let calendar = Calendar.current
        let now = currentDate
        let earliest = (now as NSDate).earlierDate(date)
        let latest = (earliest == now) ? date : now
        let components: DateComponents = (calendar as NSCalendar).components([NSCalendar.Unit.minute,
                                                                              NSCalendar.Unit.hour,
                                                                              NSCalendar.Unit.day,
                                                                              NSCalendar.Unit.weekOfYear,
                                                                              NSCalendar.Unit.month,
                                                                              NSCalendar.Unit.year,
                                                                              NSCalendar.Unit.second],
                                                                             from: earliest, to: latest,
                                                                             options: NSCalendar.Options())
        if components.year ?? 0 >= 1 {
            return yearAgo(year: components.year)
        } else if components.month ?? 0 >= 1 {
            return monthAgo(month: components.month)
        } else if components.weekOfYear ?? 0 >= 1 {
            return weekAgo(weekOfYear: components.weekOfYear)
        } else if components.day ?? 0 >= 1 {
            return dayAgo(day: components.day)
        } else if components.hour ?? 0 >= 1 {
            return hourAgo(hour: components.hour)
        } else if components.minute ?? 0 >= 1 {
            return minuteAgo(minute: components.minute)
        } else {
            return secondAgo(second: components.second)
        }
    }
    
    static func yearAgo(year: Int?) -> String {
        guard let year = year else { return "" }
        if year >= 2 {
            return String(year) + " " + "years ago"
        } else {
            return "1 " + "year ago"
        }
    }
    
    static func monthAgo(month: Int?) -> String {
        guard let month = month else { return "" }
        if month >= 2 {
            return String (month) + " " + "months ago"
        } else {
            return "1 " + "month ago"
        }
    }
    
    static func weekAgo(weekOfYear: Int?) -> String {
        guard let weekOfYear = weekOfYear else { return "" }
        if weekOfYear >= 2 {
            return String(weekOfYear) + " " + "weeks ago"
        } else {
            return "Last week"
        }
    }
    
    static func dayAgo(day: Int?) -> String {
        guard let day = day else { return "" }
        if day >= 2 {
            return String(day) + " " + "days ago"
        } else {
            return "Yesterday"
        }
    }
    
    static func hourAgo(hour: Int?) -> String {
        guard let hour = hour else { return "" }
        if hour >= 2 {
            return String(hour) + " " + "hours ago"
        } else {
            return "1 " + "hour ago"
        }
    }
    
    static func minuteAgo(minute: Int?) -> String {
        guard let minute = minute else { return "" }
        if minute >= 1 {
            return String(minute) + " " + "minutes ago"
        } else {
            return "1 " + "minute ago"
        }
    }
    
    static func secondAgo(second: Int?) -> String {
        guard let second = second else { return "" }
        if second >= 3 {
            return String(second) + " " + "seconds ago"
        } else {
            return "Just now"
        }
    }
    
    func isInSameWeek(date: Date) -> Bool {
        return Calendar.current.isDate(self, equalTo: date, toGranularity: .weekOfYear)
    }
    func isInSameMonth(date: Date) -> Bool {
        return Calendar.current.isDate(self, equalTo: date, toGranularity: .month)
    }
    func isInSameYear(date: Date) -> Bool {
        return Calendar.current.isDate(self, equalTo: date, toGranularity: .year)
    }
    func isInSameDay(date: Date) -> Bool {
        return Calendar.current.isDate(self, equalTo: date, toGranularity: .day)
    }
    var isInThisWeek: Bool {
        return isInSameWeek(date: Date())
    }
    var isInToday: Bool {
        return Calendar.current.isDateInToday(self)
    }
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    var endOfDay: Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDay)!
    }

}
