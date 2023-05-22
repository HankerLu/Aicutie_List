//
//  ViewController.swift
//  Aicuite_mobile
//
//  Created by Hanker Lu on 2023/5/12.
//

import UIKit


struct TodoItem {
    var title: String
    var isChecked: Bool
    var select_date: Date?

    init(title: String, isChecked: Bool = false) {
        self.title = title
        self.isChecked = isChecked
    }
}

class TodoItemCell: UITableViewCell {
    var isChecked = false {
        didSet {
        }
    }

}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

//    weak var delegate:UITableDelegate！
    @IBOutlet var mytblview: UITableView!
    @IBOutlet var mylabel: UILabel!
    @IBOutlet var time_display_label: UILabel!
    @IBOutlet var button_add: UIButton!
    @IBOutlet var button_remove: UIButton!
//    @IBOutlet var mytblcell_1: UITableViewCell!
//    @IBOutlet var mytblcell_2: UITableViewCell!
//    @IBOutlet var mytblcell_3: UITableViewCell!
//    @IBOutlet var mytblcell_4: UITableViewCell!
    
    var tbl_array =  [TodoItem]()
    
    var index_of_row_clicked = 0
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // print("section = \(section)")
        return tbl_array.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("indexPath.row = \(indexPath.row)")
        let cell = tableView.dequeueReusableCell(withIdentifier: "tblcell1", for: indexPath) as! TodoItemCell
        let todoItem = tbl_array[indexPath.row]
        cell.textLabel?.text = todoItem.title
        cell.isChecked = todoItem.isChecked
        cell.accessoryType = todoItem.isChecked ? .checkmark : .none
        cell.backgroundColor = .none
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index_of_row_clicked = indexPath.row
        time_display_label.text = "Current Row:\(index_of_row_clicked + 1)"
        var todoItem = tbl_array[indexPath.row]
        tbl_array[indexPath.row].isChecked = !todoItem.isChecked

        // indexPath.row % 2 == 0 ? (tableView.cellForRow(at: indexPath)?.backgroundColor = .systemPink) : (tableView.cellForRow(at: indexPath)?.backgroundColor = .systemTeal)
        // backgroundColor = .systemPink

        print("todoItem.isChecked = \(todoItem.isChecked)")
        tableView.reloadRows(at: [indexPath], with: .automatic)

        for i in 0..<tbl_array.count {
            tableView.cellForRow(at: IndexPath(row: i, section: 0))?.backgroundColor = .none
        }
        tableView.cellForRow(at: IndexPath(row: index_of_row_clicked, section: 0))?.backgroundColor = .systemPink
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "delete") { (action, view, completionHandler) in
            self.tbl_array.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            self.mylabel.text = "current cell num: \(self.tbl_array.count)"
            completionHandler(true)
        }
        let setTimeAction = UIContextualAction(style: .normal, title: "set time") { (action, view, completionHandler) in
            // let alertController = UIAlertController(title: "time", message: nil, preferredStyle: .alert)
            
            // alertController.viewDidLoad()
            // alertController.preferredContentSize = CGSize(width: 300,  height: 400)
            // // datePicker.frame = CGRect(x: 0, y: 0, width: 300, height: 150)

            // let datePicker = UIDatePicker()
            // datePicker.datePickerMode = .time
            // alertController.view.addSubview(datePicker)

            // let okAction = UIAlertAction(title: "confirm", style: .default) { (action) in
            //     let selectedTime = datePicker.date
            //     print("selectedTime...")
            // }
            // alertController.addAction(okAction)
            // let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
            // alertController.addAction(cancelAction)
            // self.present(alertController, animated: true, completion: nil)

            let popupStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let popupViewController = popupStoryboard.instantiateViewController(withIdentifier: "timeset_ID")
            // popupViewController.modalPresentationStyle = .overCurrentContext
            self.addChild(popupViewController)
            self.view.addSubview(popupViewController.view)

            popupViewController.didMove(toParent: self)
            popupViewController.view.frame = CGRect(x: 25, y: 150, width: self.view.frame.width - 50, height: self.view.frame.height - 300)
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissTaskTimeSettingVC))
            self.view.addGestureRecognizer(tapGesture)

            // self.present(popupViewController, animated: true, completion: nil)
            completionHandler(true)
        }
        setTimeAction.backgroundColor = .blue
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction, setTimeAction])
        return configuration
    }
    
    @objc func dismissTaskTimeSettingVC() {
        //reconise if the position of the tap is in the popup view
        // if yes, do nothing
        // if no, dismiss the popup view
        print("dismissTaskTimeSettingVC")
        if let popupViewController = self.children.last {
            let tapPoint = self.view.gestureRecognizers?.first?.location(in: self.view)
            let isPointInPopupView = popupViewController.view.frame.contains(tapPoint!)
            if !isPointInPopupView {
                // self.removePopup()
                self.view.gestureRecognizers?.removeAll()
                self.children.last?.willMove(toParent: nil)
                self.children.last?.view.removeFromSuperview()
                self.children.last?.removeFromParent()
                self.view.gestureRecognizers?.removeAll()
            }
        }
    } 

    override func viewDidLoad() {
        print("viewDidLoad")
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        mytblview.register(TodoItemCell.self, forCellReuseIdentifier: "tblcell1")
        // tbl_array.append("tbl data 1")
        // tbl_array.append("tbl data 2")
        // tbl_array.append("tbl data 3")
        // tbl_array.append("tbl data 4")
        
        print("tbl_array.count")
        
        button_add.addTarget(self, action: #selector(didTapButton_addtblcell), for: .touchUpInside)
        
        button_remove.addTarget(self, action: #selector(didTapButton_removetblcell), for: .touchUpInside)

        time_display_label.text = "Current Row:\(index_of_row_clicked + 1)"
        
    }
    
    @objc func didTapButton_addtblcell(){
        // add a tableview cell to the top of mytblview
        tbl_array.append(TodoItem(title: "tbl data \(tbl_array.count + 1)"))
        // mytblview.insertRows(at: [IndexPath(row: tbl_array.count - 1, section: 0)], with: .automatic)
        mylabel.text = "current cell num: \(tbl_array.count)"
        //get the last cell
        mytblview.reloadData()

    }

    @objc func didTapButton_removetblcell(){
        //detect if the tableview cell is empty
        if tbl_array.count == 0 {
            print("tbl_array.count == 0")
            return
        }
        
        // remove a tableview cell for mytblview
        tbl_array.removeLast()
        mylabel.text = "current cell num: \(tbl_array.count)"
        mytblview.reloadData()

        // let vc = storyboard?.instantiateViewController(identifier: "vc2") as! ViewController2
        // vc.modalPresentationStyle = .fullScreen
        // present(vc, animated: true)
    }

    func setToDoTaskTime(date_select_in: Date) {
        print("setToDoTaskTime")
        tbl_array[index_of_row_clicked].select_date = date_select_in
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("prepare")
        if segue.identifier == "segue_timeset" {
            // let vc = segue.destination as! TaskSettingScreen
            // vc.delegate = self
            print("receive segue_timeset")
        }
    }
}
