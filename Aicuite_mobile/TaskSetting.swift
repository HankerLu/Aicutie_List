//
//  TaskSetting.swift
//  Aicuite_mobile
//
//  Created by Hanker Lu on 2023/5/19.
//

import Foundation
import UIKit

class TaskSettingScreen: UIViewController {

    @IBOutlet var button_timeset_confirm: UIButton!
    @IBOutlet var button_timeset_cancel: UIButton!
    @IBOutlet var button_date_picker: UIDatePicker!
    @IBOutlet var button_time_hms_enable_switch: UISwitch!

    @IBAction func button_timeset_confirm_clicked(_ sender: Any) {

        // let main_storyboard = UIStoryboard(name: "Main", bundle: nil)
        // let main_targetVC = main_storyboard.instantiateViewController(withIdentifier: "main_ID")
        print("button_timeset_confirm_clicked/ button_date_picker.date = \(button_date_picker.date)")

        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
    }

    @IBAction func button_timeset_cancel_clicked(_ sender: Any) {
        print("button_timeset_cancel_clicked")
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemMint
        
        // Do any additional setup after loading the view.
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
