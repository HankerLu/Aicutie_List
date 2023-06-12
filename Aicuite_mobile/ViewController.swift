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

protocol DatePickerDelegate: AnyObject{
    // print("DatePickerDelegate")

    func didDatePicked(date: Date)
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DatePickerDelegate{

//    weak var delegate:UITableDelegate！
    @IBOutlet var mytblview: UITableView!
    @IBOutlet var mylabel: UILabel!
    @IBOutlet var time_display_label: UILabel!
    @IBOutlet var button_add: UIButton!
    @IBOutlet var button_remove: UIButton!
    @IBOutlet var button_calendar_show: UIButton!
//    @IBOutlet var mytblcell_1: UITableViewCell!
//    @IBOutlet var mytblcell_2: UITableViewCell!
//    @IBOutlet var mytblcell_3: UITableViewCell!
//    @IBOutlet var mytblcell_4: UITableViewCell!

    @IBAction func button_calendar_show_clicked(_ sender: Any) {
        print("button_feed_show_clicked")
    }
    
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
        self.set_cur_row_num_and_select_index()
        self.set_cur_task_time()
        let todoItem = tbl_array[indexPath.row]
        tbl_array[indexPath.row].isChecked = !todoItem.isChecked

        // indexPath.row % 2 == 0 ? (tableView.cellForRow(at: indexPath)?.backgroundColor = .systemPink) : (tableView.cellForRow(at: indexPath)?.backgroundColor = .systemTeal)
        // backgroundColor = .systemPink

        print("todoItem.isChecked = \(todoItem.isChecked)")
        tableView.reloadRows(at: [indexPath], with: .automatic)

        for i in 0..<tbl_array.count {
            tableView.cellForRow(at: IndexPath(row: i, section: 0))?.backgroundColor = .none
        }
        tableView.cellForRow(at: IndexPath(row: index_of_row_clicked, section: 0))?.backgroundColor = .systemGray
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "delete") { (action, view, completionHandler) in
            self.tbl_array.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            // self.mylabel.text = "num: \(self.tbl_array.count) select: \(index_of_row_clicked + 1)"
            self.set_cur_row_num_and_select_index()
            completionHandler(true)
        }
        let setTimeAction = UIContextualAction(style: .normal, title: "set time") { (action, view, completionHandler) in
            let popupStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let popupViewController = popupStoryboard.instantiateViewController(withIdentifier: "timeset_ID")
            if let popupViewController = popupViewController as? TaskSettingScreen {
                print("popupViewController = segue.destination as? TaskSettingScreen")
                        popupViewController.delegate = self
            }
            self.addChild(popupViewController)
            self.view.addSubview(popupViewController.view)
            popupViewController.didMove(toParent: self)
            // self.present(popupViewController, animated: true, completion: nil)

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
            }
        }
    } 

    override func viewDidLoad() {
        print("viewDidLoad")
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        mytblview.register(TodoItemCell.self, forCellReuseIdentifier: "tblcell1")
        // tbl_array.append("tbl data 1")
        // tbl_array.append("tbl data 2")
        // tbl_array.append("tbl data 3")
        // tbl_array.append("tbl data 4")
        
        print("tbl_array.count")
        
        button_add.addTarget(self, action: #selector(didTapButton_addtblcell), for: .touchUpInside)
        
        button_remove.addTarget(self, action: #selector(didTapButton_removetblcell), for: .touchUpInside)

        self.set_cur_row_num_and_select_index()
        
    }
    
    @objc func didTapButton_addtblcell(){
        // add a tableview cell to the top of mytblview
        tbl_array.append(TodoItem(title: "tbl data \(tbl_array.count + 1)"))
        // mytblview.insertRows(at: [IndexPath(row: tbl_array.count - 1, section: 0)], with: .automatic)
        self.set_cur_row_num_and_select_index()
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
        self.set_cur_row_num_and_select_index()
        mytblview.reloadData()

        // let vc = storyboard?.instantiateViewController(identifier: "vc2") as! ViewController2
        // vc.modalPresentationStyle = .fullScreen
        // present(vc, animated: true)
    }

    func setToDoTaskTime(date_select_in: Date) {
        print("setToDoTaskTime")
        tbl_array[index_of_row_clicked].select_date = date_select_in
    }

    func didDatePicked(date: Date) {
        print("didDatePicked")
        tbl_array[index_of_row_clicked].select_date = date
        self.set_cur_task_time()
        print("index_of_row_clicked = \(index_of_row_clicked) date = \(date)")
    }

    func set_cur_row_num_and_select_index() {
        self.mylabel.text = "num: \(self.tbl_array.count) select: \(self.index_of_row_clicked + 1)"
    }

    func set_cur_task_time() {
        if let date_in = tbl_array[index_of_row_clicked].select_date {
            time_display_label.text = "\(date_in)"
        }
        else {
            time_display_label.text = "no time set"
        }
    }
}
