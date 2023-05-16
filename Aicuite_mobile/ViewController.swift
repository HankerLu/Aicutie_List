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
    @IBOutlet var mybutton: UIButton!
//    @IBOutlet var mytblcell_1: UITableViewCell!
//    @IBOutlet var mytblcell_2: UITableViewCell!
//    @IBOutlet var mytblcell_3: UITableViewCell!
//    @IBOutlet var mytblcell_4: UITableViewCell!
    
    var tbl_array =  [String]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("section = \(section)")
        return tbl_array.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("indexPath.row = \(indexPath.row)")
        let cell = tableView.dequeueReusableCell(withIdentifier: "tblcell1", for: indexPath) 
        cell.textLabel?.text = tbl_array[indexPath.row]
        return cell
    }


    override func viewDidLoad() {
        print("viewDidLoad")
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        mytblview.register(UITableViewCell.self, forCellReuseIdentifier: "tblcell1")
        mytblview.register(UITableViewCell.self, forCellReuseIdentifier: "tblcell2")
        mytblview.register(UITableViewCell.self, forCellReuseIdentifier: "tblcell3")
        mytblview.register(UITableViewCell.self, forCellReuseIdentifier: "tblcell4")
        tbl_array.append("tbl data 1")
        tbl_array.append("tbl data 2")
        tbl_array.append("tbl data 3")
        tbl_array.append("中文格")
        tbl_array.append("中文格2")
        print("tbl_array.count")
        
        mybutton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    @objc func didTapButton(){
        print("didTapButton")
        // let vc = storyboard?.instantiateViewController(identifier: "vc2") as! ViewController2
        // vc.modalPresentationStyle = .fullScreen
        // present(vc, animated: true)
    }

}

