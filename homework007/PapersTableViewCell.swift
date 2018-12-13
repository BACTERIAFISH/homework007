//
//  PapersTableViewCell.swift
//  homework008
//
//  Created by FISH on 2018/12/9.
//  Copyright © 2018年 FISH. All rights reserved.
//

import UIKit

class PapersTableViewCell: UITableViewCell {
    var urlStr: String?
    @IBOutlet weak var paperTitle: UILabel!
    @IBOutlet weak var authorNames: UILabel!
    @IBOutlet weak var paperSource: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
   
    
    
}
