//
//  WikiSearchTableViewCell.swift
//  WikiSearch
//
//  Created by Sunil on 18/08/18.
//  Copyright © 2018 Sunil Sharma. All rights reserved.
//

import UIKit

class WikiSearchTableViewCell: UITableViewCell {

    @IBOutlet weak var thumnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        thumnailImageView.clipsToBounds = true
        thumnailImageView.layer.cornerRadius = 4
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func updateViewWith(data: SearchData) {
        titleLabel.text = data.title
        descriptionLabel.text = data.description
        thumnailImageView.sd_setImage(with: URL(string: data.thumbnailUrl ?? ""),
                                    placeholderImage: UIImage(named: "placeholder"), options: [.retryFailed], completed: nil)
    }
    
}
