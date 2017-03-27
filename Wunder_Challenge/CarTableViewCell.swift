//
//  CarTableViewCell.swift
//  Wunder_Challenge
//
//  Created by Mohamed Magdy on 3/26/17.
//  Copyright © 2017 Mohamed Magdy. All rights reserved.
//

import UIKit

class CarTableViewCell: UITableViewCell {

    //MARK:- Outlets
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var addressLabel: UILabel!
    
    
    //MARK:- Utils
    func customizeCell(withModel model:CarViewModel?) {
        nameLabel.text = model?.name
        addressLabel.text = model?.address
    }
    
    //MARK:- Init
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
