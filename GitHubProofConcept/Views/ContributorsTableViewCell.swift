//
//  ContributorsTableViewCell.swift
//  GitHubProofConcept
//
//  Created by Developer on 18/7/19.
//  Copyright © 2019 Developer. All rights reserved.
//

import UIKit

class ContributorsTableViewCell: UITableViewCell {

    @IBOutlet weak var mImageView: UIImageView!
    @IBOutlet weak var mTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        mImageView.setRounded()
    }
    
    func setContributorCellWith(contributor: ContributorMO) {
        DispatchQueue.main.async {
            self.mTitleLabel.text = contributor.login
            if let url = contributor.avatar_url {
                self.mImageView.loadImageUsingCacheWithURLString(url, placeHolder: UIImage(named: "DefaultAvatar"))
            }
        }
    }
    
}
