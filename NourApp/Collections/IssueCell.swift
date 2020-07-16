//
//  IssueCell.swift
//  NourApp
//
//  Created by Abdelrahman Samir on 6/27/20.
//  Copyright © 2020 Abdelrahman Samir. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage
import Alamofire

class IssueCell: UICollectionViewCell {

    var view = UIView()
    var issueBackground = UIImageView()
    var issueTitle : UILabel = UILabel()
    var alphaView = UIView()
    var deleteIssue = UIButton(type: .custom)
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        issueBackground.translatesAutoresizingMaskIntoConstraints = false
        issueTitle.translatesAutoresizingMaskIntoConstraints = false
        alphaView.translatesAutoresizingMaskIntoConstraints = false
        deleteIssue.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .brown
        view.layer.cornerRadius = 10
        view.layer.masksToBounds  = true
        
        contentView.addSubview(view)
        view.addSubview(issueBackground)
        alphaView.addSubview(issueTitle)
        alphaView.addSubview(deleteIssue)
        view.addSubview(alphaView)
        
        
        view.topAnchor.constraint(equalTo: contentView.topAnchor , constant: 20).isActive = true
        view.leftAnchor.constraint(equalTo: contentView.leftAnchor ,constant:  20).isActive = true
        view.rightAnchor.constraint(equalTo: contentView.rightAnchor , constant: -20).isActive = true
        view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor , constant: -20).isActive = true
        
        issueBackground.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        issueBackground.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        issueBackground.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        issueBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        alphaView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.4524293664)
        alphaView.clipsToBounds = false
        issueTitle.textColor = .white
        if #available(iOS 13.0, *) {
            deleteIssue.setBackgroundImage(.remove, for: .normal)
        } else {

        }

        alphaView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        alphaView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        alphaView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        alphaView.heightAnchor.constraint(equalToConstant: 30).isActive = true

        deleteIssue.centerYAnchor.constraint(equalTo: alphaView.centerYAnchor).isActive = true
        deleteIssue.trailingAnchor.constraint(equalTo: alphaView.trailingAnchor,constant: -10).isActive = true
        
        issueTitle.centerYAnchor.constraint(equalTo: alphaView.centerYAnchor).isActive = true
        issueTitle.leadingAnchor.constraint(equalTo: alphaView.leadingAnchor,constant: 10).isActive = true
        issueBackground.contentMode = .scaleAspectFill
        issueBackground.clipsToBounds = true
        
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    func initIssueCell(issueTitle:String , issueBackgroundUrl: String) -> Void {
        self.issueTitle.text = issueTitle
        self.issueBackground.image = UIImage(named: "noor")
        
        AF.request(issueBackgroundUrl).responseImage(completionHandler: {
            response in
            guard let _ = response.value else {
                return
                }
            self.issueBackground.image = response.value
            }
        )
        
    }

    
    
}
