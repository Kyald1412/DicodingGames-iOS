//
//  CommonFunction.swift
//  DicodingGames
//
//  Created by Dhiky Aldwiansyah on 01/07/20.
//  Copyright © 2020 Dhiky Aldwiansyah. All rights reserved.
//

import Foundation


func getDateWithYearModify(year: Int) -> String {
    let today = Date()
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    
    var dateComponent = DateComponents()
    dateComponent.year = year
    let futureDate = Calendar.current.date(byAdding: dateComponent, to: today)

    return formatter.string(from: futureDate!)
}
