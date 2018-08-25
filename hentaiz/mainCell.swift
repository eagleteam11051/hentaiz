//
//  mainCell.swift
//  hentaiz
//
//  Created by Thắng Nguyễn Hoàng on 8/25/18.
//  Copyright © 2018 Thắng Nguyễn Hoàng. All rights reserved.
//

import UIKit

class mainCell: UITableViewCell {

    @IBOutlet weak var imaDanhsach: UIImageView!
    @IBOutlet weak var lblTieuDe: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
