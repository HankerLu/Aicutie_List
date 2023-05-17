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
            print("isChecked = \(isChecked)")
        }
    }

}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

//    weak var delegate:UITableDelegate！
    @IBOutlet var mytblview: UITableView!
    @IBOutlet var mylabel: UILabel!
    @IBOutlet var button_add: UIButton!
    @IBOutlet var button_remove: UIButton!
//    @IBOutlet var mytblcell_1: UITableViewCell!
//    @IBOutlet var mytblcell_2: UITableViewCell!
//    @IBOutlet var mytblcell_3: UITableViewCell!
//    @IBOutlet var mytblcell_4: UITableViewCell!
    
    var tbl_array =  [TodoItem]()
    
    //define a counter variable
    var counter_of_button_clicked = 0
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // print("section = \(section)")
        return tbl_array.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // print("indexPath.row = \(indexPath.row)")
        let cell = tableView.dequeueReusableCell(withIdentifier: "tblcell1", for: indexPath) as! TodoItemCell
        var todoItem = tbl_array[indexPath.row]
        cell.textLabel?.text = todoItem.title
        cell.isChecked = todoItem.isChecked
        cell.accessoryType = todoItem.isChecked ? .checkmark : .none
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var todoItem = tbl_array[indexPath.row]
        // print("before todoItem.isChecked = \(todoItem.isChecked)")
        todoItem.isChecked = !todoItem.isChecked
        tbl_array[indexPath.row].isChecked = todoItem.isChecked
        print("todoItem.isChecked = \(todoItem.isChecked)")
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }

    // func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> TodoItemCell {
    // // print("indexPath.row = \(indexPath.row)")
    // let cell = tableView.dequeueReusableCell(withIdentifier: "tblcell1", for: indexPath)  as! TodoItemCell
    // cell.textLabel?.text = tbl_array[indexPath.row].title
    // return cell
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
        
    }
    
    @objc func didTapButton_addtblcell(){
        print("didTapButton_addtblcell, counter_of_button_clicked = \(counter_of_button_clicked)")
        counter_of_button_clicked += 1
        mylabel.text = "current cell num: \(counter_of_button_clicked)"
        
        // add a tableview cell to the top of mytblview
        // tbl_array.insert(TodoItem(title: "tbl data \(counter_of_button_clicked)"), at: 0)
        tbl_array.append(TodoItem(title: "tbl data \(counter_of_button_clicked)"))
        mytblview.insertRows(at: [IndexPath(row: tbl_array.count - 1, section: 0)], with: .automatic)
        // Reference to member 'insertRows' cannot be resolved without a contextual type
        // tbl_array.append("tbl data \(counter_of_button_clicked)")

        //get the last cell
        mytblview.reloadData()

        // let cell = mytblview.cellForRow(at: IndexPath(row: tbl_array.count-1, section: 0)) as! TodoItemCell
        let cell = mytblview.dequeueReusableCell(withIdentifier: "tblcell1", for: IndexPath(row: tbl_array.count-1, section: 0)) as! TodoItemCell
        // print("view X Y \(view.frame.origin.x) \(view.frame.origin.y)")
        // print("cell X Y \(cell?.frame.origin.x) \(cell?.frame.origin.y)")
        // print("table W H \(mytblview.frame.size.width) \(mytblview.frame.size.height)")
        let nextButton = cell.checkboxButton
        // nextButton = cell.checkboxButton
        cell.contentView.addSubview(nextButton)
        // mytblview.addSubview(nextButton)
        nextButton.configuration = .filled()
        // nextButton.configuration?.baseBackgroundColor = .systemPink
        nextButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            // nextButton.centerXAnchor.constraint(equalTo: mytblview.leftAnchor, constant: 15),
            // nextButton.centerYAnchor.constraint(equalTo: mytblview.centerYAnchor),
            nextButton.centerXAnchor.constraint(equalTo: cell.contentView.centerXAnchor),
            nextButton.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
            nextButton.widthAnchor.constraint(equalToConstant: 25),
            nextButton.heightAnchor.constraint(equalToConstant: 25)
         ])

    }

    @objc func didTapButton_removetblcell(){
        //detect if the tableview cell is empty
        if tbl_array.count == 0 {
            print("tbl_array.count == 0")
            return
        }
        print("didTapButton_removetblcell, counter_of_button_clicked = \(counter_of_button_clicked)")
        counter_of_button_clicked -= 1
        mylabel.text = "current cell num: \(counter_of_button_clicked)"
        
        // remove a tableview cell for mytblview
        tbl_array.removeLast()
        mytblview.reloadData()

        // let vc = storyboard?.instantiateViewController(identifier: "vc2") as! ViewController2
        // vc.modalPresentationStyle = .fullScreen
        // present(vc, animated: true)
    }

}
