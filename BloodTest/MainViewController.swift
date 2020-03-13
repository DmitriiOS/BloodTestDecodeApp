//
//  MainViewController.swift
//  BloodTest
//
//  Created by 1 on 25.02.2020.
//  Copyright © 2020 DmitriOS. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {
    
    var decodeOption = false
    
    @IBOutlet weak var decodeButton: UIBarButtonItem!
    
    @IBAction func decodeButtonTapeed(_ sender: UIBarButtonItem) {
        
        decodeOption = true
        decodeButton.isEnabled = false
        tableView.reloadData()
        
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        decodeOption = false
        decodeButton.isEnabled = true
        tableView.reloadData()
    }
    
    var bloodComponentsFilled = [Blood]()
    
    var bloodComponents = [
    Blood(componentName: "Компонент крови", compDescription: "Описание компонента крови.", currentVolume: nil, minNormVolume: 10, maxNormVolume: 20, decodeIfNormal: "Показатель в пределах нормы.", decodeIfMore: "Показатель превышает норму. Это может быть признаком болезни.", decodeIfLess: "Показатель ниже нормы. Это может быть признаком нехватки чего-то в организме."),
    Blood(componentName: "Эритроциты, × 10х12/л (RBC)", compDescription: "RBC (эритроциты) — красные кровяные тельца, переносящие гемоглобин. Главная функция эритроцитов транспортировка кислорода из лёгких ко всем тканям и двуокись углерода — от тканей обратно в лёгкие. Мало эритроцитов — мало гемоглобина. Мало гемоглобина — мало эритроцитов. Они взаимосвязаны.", currentVolume: nil, minNormVolume: 5, maxNormVolume: 15, decodeIfNormal: "вы здоровы", decodeIfMore: "Это плохо", decodeIfLess: "это тоже не хорошо")
//    Blood(componentName: "Средний объем эритроцитов, фл или мкм3 (MCV)",
//          compDescription: "MCV (средний объём эритроцита) — индекс среднего объёма эритроцитов."),
//    Blood(componentName: "Гемоглобин, г/л (HGB)",
//          compDescription: "HGB (гемоглобин) — Белок, содержащийся в эритроцитах и отвечающий за перенос молекул кислорода к клеткам организма. Уровень гемоглобина не является постоянной величиной и зависит от возраста, пола, этнической принадлежности, заболевания, курения, у женщин — от беременности и т.д."),
//    Blood(componentName: "Средний уровень HGB в эритроците, пг (MCH)", compDescription: "MCH (средний объём гемоглобина) — среднее количество гемоглобина в отдельном эритроците: в красных кровяных тельцах."),
//    Blood(componentName: "Цветной показатель (ЦП)", compDescription: "need data"),
//    Blood(componentName: "Гематокрит, в % соотношении (HCT)", compDescription: "HCT (гематокрит) — показывает в процентах индекс объёма эритроцитов к объёму всего образца крови."),
//    Blood(componentName: "Тромбоциты, × 10х9/л (PLT)", compDescription: "PLT (тромбоциты) — клетки, влияющие на процессы свёртывания крови. Тромбоциты отвечают за гемостаз, заживление ран и остановку кровотечения. Анализ тромбоцитов важен при болезнях костного мозга, в котором они образуются."),
//    Blood(componentName: "Средняя концентрация эритроцитов в гемоглобине, % (MCHC)", compDescription: "MCHC — средняя концентрация гемоглобина в эритроците."),
//    Blood(componentName: "Ретикулоциты, % (RET)", compDescription: "need data"),
//    Blood(componentName: "Лейкоциты, × 10х9/л (WBC)", compDescription: "WBC (лейкоциты) — белые или бесцветные клетки крови различных размеров. Основная функция лейкоцитов — противодействовать инфекциям, вирусам, бактериям и т.д. Лейкоциты делятся на 5 типов: нейтрофилы, лимфоциты, моноциты, эозинофилы и базофилы."),
//    Blood(componentName: "Средний объем тромбоцитов, фл или мкм3 (MPV)", compDescription: "MPV (средний объём тромбоцитов) — индекс среднего объёма тромбоцитов."),
//    Blood(componentName: "Скорость оседания эритроцитов, мм/ч (СОЭ, ESR)", compDescription: "СОЭ — скорость оседания эритроцитов. Неспецифический лабораторный показатель крови, отражающий соотношение фракций белков плазмы; изменение СОЭ может служить косвенным признаком текущего воспалительного или иного патологического процесса."),
//    Blood(componentName: "Анизоцитоз эритроцитов, % (RFV)", compDescription: "need data")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        switchVolumes()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("Возраст: \(PersonInfo.shared.userAgeInMonths)")
        tableView.reloadData()
        switchVolumes()
    }
    
    func switchVolumes() {
        switch PersonInfo.shared.userAgeInMonths {
        case 0..<12:
            bloodComponents[0].minNormVolume = 1
            bloodComponents[0].maxNormVolume = 10
            bloodComponents[1].minNormVolume = 4.1
            bloodComponents[1].maxNormVolume = 5.3
        default:
            bloodComponents[0].minNormVolume = 2
            bloodComponents[0].maxNormVolume = 20
            bloodComponents[1].minNormVolume = 3.8
            bloodComponents[1].maxNormVolume = 4.8
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if decodeOption {
            bloodComponentsFilled = bloodComponents.filter {$0.currentVolume != nil}
            return bloodComponentsFilled.count
        } else {
            return bloodComponents.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if decodeOption {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CellDecode", for: indexPath) as! CustomDecodeTableViewCell
            
            cell.componentLabel?.text = bloodComponentsFilled[indexPath.row].componentName
            cell.descriptionLabel?.text = bloodComponentsFilled[indexPath.row].decodeIfNormal
            cell.normalValueLabel?.text = "\(bloodComponentsFilled[indexPath.row].minNormVolume!) - \(bloodComponentsFilled[indexPath.row].maxNormVolume!)"
            cell.userValueLabel?.text = "\(bloodComponentsFilled[indexPath.row].currentVolume!)"
            
            return cell

        } else {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell

        cell.bloodComponentLabel?.text = bloodComponents[indexPath.row].componentName
        cell.descriptionButtonTapped = {
            let alert = UIAlertController(title: self.bloodComponents[indexPath.row].componentName, message: self.bloodComponents[indexPath.row].compDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
//            print(self.bloodComponents[indexPath.row].compDescription)
        }
            
            if let currentVol = cell.bloodComponentVolumeField.text {
            bloodComponents[indexPath.row].currentVolume = Double(currentVol)
            }
            
        return cell
        }
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        view.endEditing(true)
    }
  
    

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
