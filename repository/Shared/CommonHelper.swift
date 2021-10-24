//
//  CommonHelper.swift
//  repository
//
//  Created by pankaj.k.jha on 24/10/21.
//

import Foundation
import UIKit
let dateFormatter = DateFormatter()
struct PKFontSize {
    static let heavyWeight = UIFont(name: "AvenirNext-DemiBold", size: 24)
    static let middleWeight = UIFont(name: "AvenirNext-DemiBold", size: 18)
    static let regular = UIFont(name: "AvenirNext-DemiBold", size: 16)
    static let walter = UIFont(name: "AvenirNext-DemiBold", size: 15)
    static let light = UIFont(name: "AvenirNext-Regular", size: 14)
}

struct PKDefaultColor {
    static let label = UIColor(red: 0.227, green: 0.259, blue: 0.463, alpha: 1)
    static let buttonBackground = UIColor(red: 1, green: 0.675, blue: 0.188, alpha: 1)
    static let background = UIColor(red: 0.945, green: 0.953, blue: 0.965, alpha: 1)
}

struct PKDateHelper {
    
    static func convertDate(_ date: String) -> String {
        //2011-06-07T04:13:28.097554+00:00
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "dd MMM YYYY"
        return  dateFormatter.string(from: date!)
        
    }
}
