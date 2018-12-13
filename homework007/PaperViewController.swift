//
//  PaperViewController.swift
//  homework008
//
//  Created by FISH on 2018/12/9.
//  Copyright © 2018年 FISH. All rights reserved.
//

import UIKit

class PaperViewController: UIViewController, UITableViewDataSource {
    var papers: [[String: String]]?

    @IBOutlet weak var papersTable: UITableView!
    @IBOutlet weak var backButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var num:Int = 0
        if let papers = papers {
            num = papers.count
        }
        return num
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PaperCell", for: indexPath) as? PapersTableViewCell else {
            return UITableViewCell()
        }
        
        if let papers = papers {
            cell.paperTitle.text = papers[indexPath.row]["title"]
            cell.authorNames.text = papers[indexPath.row]["authorNames"]
            cell.paperSource.text = papers[indexPath.row]["source"]
        }
        
        return cell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let controller = segue.destination as? WebViewController
        if let papers = papers, let row = papersTable.indexPathForSelectedRow?.row {
            controller?.urlStr = papers[row]["urlStr"]
        }
        
    }
 
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
