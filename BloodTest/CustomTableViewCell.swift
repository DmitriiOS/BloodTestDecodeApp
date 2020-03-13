//
//  CustomTableViewCell.swift
//  BloodTest
//
//  Created by 1 on 26.02.2020.
//  Copyright © 2020 DmitriOS. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    var descriptionButtonTapped: (() -> Void)!

    @IBAction func infoButtonPressed(_ sender: UIButton) {
        descriptionButtonTapped()
    }
    @IBAction func bloodComponentTextField(_ sender: UITextField) {
    }
    
    @IBOutlet weak var bloodComponentVolumeField: UITextField!
    @IBOutlet weak var bloodComponentLabel: UILabel!
    
}


