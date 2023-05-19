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

    init(title: String, isChecked: Bool = false) {
        self.title = title
        self.isChecked = isChecked
    }
}

class TodoItemCell: UITableViewCell {
    var checkboxButton = UIButton()

    var isChecked = false {
        didSet {
            // let imageName = isChecked ? "checkbox_checked" : "checkbox_unchecked"
            // checkboxButton.setImage(UIImage(named: imageName), for: .normal)
            // print("isChecked = \(isChecked)")
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

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        print("editingStyle = \(editingStyle)")
        if editingStyle == .delete {
            // 删除对应的数据
            tbl_array.remove(at: indexPath.row)
            // 删除对应的行
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        mylabel.text = "current cell num: \(tbl_array.count + 1)"
    }

    // func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    //     print("canEditRowAt")
    //     return true
    // }

    // func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
    //     print("editActionsForRowAt")
    //     // let deleteAction = UIContextualAction(style: .destructive, title: "删除") { (action, view, finished) in
    //     //     self.tbl_array.remove(at: indexPath.row)
    //     //     tableView.deleteRows(at: [indexPath], with: .fade)
    //     //     finished(true)
    //     // }
    //     let deleteAction = UITableViewRowAction(style: .destructive, title: "删除") { (action, indexPath) in
    //         self.tbl_array.remove(at: indexPath.row)
    //         tableView.deleteRows(at: [indexPath], with: .fade)
    //     }
    //     return [deleteAction]
    // }
    
    

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

        // let cell = mytblview.dequeueReusableCell(withIdentifier: "tblcell1", for: IndexPath(row: tbl_array.count-1, section: 0)) as! TodoItemCell
        // let nextButton = cell.checkboxButton
        // cell.contentView.addSubview(nextButton)
        // nextButton.configuration = .filled()
        // // nextButton.configuration?.baseBackgroundColor = .systemPink
        // nextButton.translatesAutoresizingMaskIntoConstraints = false
        // NSLayoutConstraint.activate([
        //     // nextButton.centerXAnchor.constraint(equalTo: mytblview.leftAnchor, constant: 15),
        //     // nextButton.centerYAnchor.constraint(equalTo: mytblview.centerYAnchor),
        //     nextButton.centerXAnchor.constraint(equalTo: cell.contentView.centerXAnchor),
        //     nextButton.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
        //     nextButton.widthAnchor.constraint(equalToConstant: 25),
        //     nextButton.heightAnchor.constraint(equalToConstant: 25)
        //  ])

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

}
