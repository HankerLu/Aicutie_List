//
//  ViewController.swift
//  Aicuite_mobile
//
//  Created by Hanker Lu on 2023/5/12.
//

import UIKit

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
    
    var tbl_array =  [String]()
    
    //define a counter variable
    var counter_of_button_clicked = 0
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // print("section = \(section)")
        return tbl_array.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // print("indexPath.row = \(indexPath.row)")
        let cell = tableView.dequeueReusableCell(withIdentifier: "tblcell1", for: indexPath) 
        cell.textLabel?.text = tbl_array[indexPath.row]
        return cell
    }

    override func viewDidLoad() {
        print("viewDidLoad")
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        mytblview.register(UITableViewCell.self, forCellReuseIdentifier: "tblcell1")
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
        tbl_array.insert("tbl data \(counter_of_button_clicked)", at: 0)
        // tbl_array.append("tbl data \(counter_of_button_clicked)")

        //get the last cell
        mytblview.reloadData()

        let button = UIButton()
        button.setTitle("Button", for: .normal)
        // button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        //get the top cell if mytblview
        // let cell = mytblview.cellForRow(at: IndexPath(row: 0, section: 0))
        let cell = mytblview.cellForRow(at: IndexPath(row: tbl_array.count-1, section: 0))
//        if cell != nil {
//            print("cell is not nil")
//        }
//        else {
//            print("cell is nil")
//        }
        print("view X Y \(view.frame.origin.x) \(view.frame.origin.y)")
        print("cell X Y \(cell?.frame.origin.x) \(cell?.frame.origin.y)")
        print("table W H \(mytblview.frame.size.width) \(mytblview.frame.size.height)")
        
        
        let nextButton = UIButton()
        // cell?.contentView.addSubview(button)
        mytblview.addSubview(nextButton)
    
        nextButton.configuration = .filled()
        nextButton.configuration?.baseBackgroundColor = .systemPink
        // nextButton.configuration?.title = "Next"

        // nextButton.addTarget(self, action: #selector(didTapButton_addtblcell), for: .touchUpInside)
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            //set nextButton's X Y to the cell's X Y
            nextButton.centerXAnchor.constraint(equalTo: mytblview.leftAnchor, constant: 15),
            nextButton.centerYAnchor.constraint(equalTo: mytblview.centerYAnchor),
            nextButton.widthAnchor.constraint(equalToConstant: 25),
            nextButton.heightAnchor.constraint(equalToConstant: 25)
         ])
            

        // let vc = storyboard?.instantiateViewController(identifier: "vc2") as! ViewController2
        // vc.modalPresentationStyle = .fullScreen
        // present(vc, animated: true)
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

