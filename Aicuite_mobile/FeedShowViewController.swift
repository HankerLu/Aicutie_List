//
//  FeedShowViewController.swift
//  Aicuite_mobile
//
//  Created by Hanker Lu on 2023/5/23.
//

import UIKit

class FeedShowViewController: UIViewController {

    @IBOutlet var button_feed_show_label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        button_feed_show_label.numberOfLines = 0
        button_feed_show_label.text = "FeedShowView \n feed show data"
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
