//
//  ContributorDetailViewController.swift
//  GitHubProofConcept
//
//  Created by Developer on 19/7/19.
//  Copyright © 2019 Developer. All rights reserved.
//

import UIKit

class ContributorDetailViewController: UIViewController {
    @IBOutlet weak var mImageView: UIImageView!
    @IBOutlet weak var mTitleLabel: UILabel!
    @IBOutlet weak var mUsernameLabel: UILabel!
    @IBOutlet weak var mEmailLabel: UILabel!
    
    var contributor: ContributorMO?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = contributor?.login
        mTitleLabel.text = contributor?.login
        mImageView.setRounded()
        if let url = contributor?.avatar_url {
            mImageView.loadImageUsingCacheWithURLString(url, placeHolder: UIImage(named: "DefaultAvatar"))
        }
        mUsernameLabel.text = contributor?.name
        mEmailLabel.text = contributor?.email ?? "No public email"
    }
}
