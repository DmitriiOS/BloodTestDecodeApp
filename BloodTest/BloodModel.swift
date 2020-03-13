//
//  BloodModel.swift
//  BloodTest
//
//  Created by 1 on 26.02.2020.
//  Copyright © 2020 DmitriOS. All rights reserved.
//

import UIKit

struct Blood {
    
    var componentName: String
    var compDescription: String
    var currentVolume: Double?
    var minNormVolume: Double?
    var maxNormVolume: Double?
    var decodeIfNormal: String
    var decodeIfMore: String
    var decodeIfLess: String
    
    func decodeInfo() -> String {
        
        if currentVolume! < minNormVolume! {
            return decodeIfLess
        } else if currentVolume! > maxNormVolume! {
            return decodeIfMore
        } else {
            return decodeIfNormal
        }
    }
    
}
