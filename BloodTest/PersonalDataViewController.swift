//
//  PersonalDataViewController.swift
//  BloodTest
//
//  Created by 1 on 28.02.2020.
//  Copyright © 2020 DmitriOS. All rights reserved.
//

import UIKit

class PersonInfo {
    static let shared = PersonInfo()
    
    var userName = ""
    var userGender = 0 //0 - male, 1 - female
    var userAgeInMonths = 0
}

class PersonalDataViewController: UIViewController, UITextFieldDelegate {
    

    

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var dateOfBirthPicker: UIDatePicker!
    @IBOutlet weak var genderSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.nameField.delegate = self
        
        dateOfBirthPicker.maximumDate = Date()
        dateOfBirthPicker.locale = Locale(identifier: "ru_RU")
        
        
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        PersonInfo.shared.userName = nameField.text ?? "не указано"
        PersonInfo.shared.userGender = genderSegmentedControl.selectedSegmentIndex
        PersonInfo.shared.userAgeInMonths = userAge()
        
        
         print("User name: \(nameField.text ?? "")")
        if genderSegmentedControl.selectedSegmentIndex == 0 {
            print ("Пол: мужской")
        } else {
            print("Пол: женский")
        }
        print("Возраст: \(PersonInfo.shared.userAgeInMonths) месяцев")
        
        
     }
     
     @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        dateOfBirthPicker.date = Date()
        nameField.text = nil
        genderSegmentedControl.selectedSegmentIndex = 0
     }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameField.resignFirstResponder()
        return true
    }

    func userAge() -> Int {
        let dateOfBirth = dateOfBirthPicker.date
        let gregorian = Calendar(identifier: .gregorian)
        let ageComponents = gregorian.dateComponents([.month], from: dateOfBirth, to: Date())
        let age = ageComponents.month!
        
//        if age < 12 {
//            let ageMonths = "\(age) месяцев"
//            return ageMonths
//        } else {
//            let ageYears = "\(age / 12) лет"
//            return ageYears
//        }
        return age
    }
    

}
