//
//  TSDateTranform.swift
//  BaseSwift
//
//  Created by nava on 7/13/18.
//  Copyright © 2018 nava. All rights reserved.
//

import Foundation
import Foundation
import ObjectMapper

open class TSDateTransform: DateFormatterTransform {
    public init() {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = DateFormat.yyyymdHmsZ
        super.init(dateFormatter: formatter)
    }
}
open class TSUserDateTransform: DateFormatterTransform {
    public init() {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = DateFormat.ddMMyyyy
        super.init(dateFormatter: formatter)
    }
}
open class TSDateFullTransform:DateFormatterTransform{
    public init() {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = DateFormat.yyyyMdHms
        super.init(dateFormatter: formatter)
    }
}
