//
//  FJExampleCell.swift
//  JiuHuarSalesOrder
//
//  Created by jin fu on 2017/12/15.
//  Copyright © 2017年 jin fu. All rights reserved.
//

import UIKit
import Kingfisher

class FJExampleCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var beerImageView: UIImageView!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    var model: BeerModel? {
        didSet {
            if let beerModel = model {
                self.configData(model: beerModel)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configData(model: BeerModel) {
        if var mainPic = model.mainPic {
            mainPic = "https://obxf7cs2k.qnssl.com/\(mainPic)"
            beerImageView.kf.setImage(with: URL(string: mainPic))
        }
        titleLabel.text = model.chineseName
        subTitleLabel.text = model.englishName
    }
}
