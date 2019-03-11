//
//  TableViewCell.swift
//  librosCarmelo
//
//  Created by dam on 25/2/19.
//  Copyright © 2019 dam. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var autor: UILabel!
    @IBOutlet weak var editorial: UILabel!
    @IBOutlet weak var nombre: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
