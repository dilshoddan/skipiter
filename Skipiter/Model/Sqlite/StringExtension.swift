//
//  StringExtension.swift
//  Skipiter
//
//  Created by Admin on 12/21/18.
//  Copyright © 2018 Home. All rights reserved.
//

import Foundation


extension Date
{
    func ToString(dateFormat format  : String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
}
