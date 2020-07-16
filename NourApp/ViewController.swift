//
//  ViewController.swift
//  NourApp
//
//  Created by Abdelrahman Samir on 6/24/20.
//  Copyright © 2020 Abdelrahman Samir. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class ViewController: UIViewController {
    
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var localizationImage: UIImageView!
    var dataRequest :Request!
    
    var issuesCVFL: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    var issuesCV: UICollectionView?
    var issues : [Issue] = []
    
    @objc func getAllData() {
        self.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        issuesCVFL.minimumLineSpacing = 0
        issuesCVFL.minimumInteritemSpacing = 0
        issuesCV = UICollectionView(frame: .zero, collectionViewLayout: issuesCVFL)
        view.addSubview(issuesCV!)
        issuesCV?.translatesAutoresizingMaskIntoConstraints = false
        issuesCV?.register(IssueCell.self, forCellWithReuseIdentifier: "issueCell")
        issuesCV?.delegate = self
        issuesCV?.dataSource = self
        issuesCV?.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        issuesCV?.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        issuesCV?.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        issuesCV?.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        issuesCV?.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        var refreshControl :UIRefreshControl {
           let refreshContorl = UIRefreshControl()
            refreshContorl.tintColor = .white
            refreshContorl.addTarget(self, action: #selector(getAllData), for: .valueChanged)
            return refreshContorl
        }
        
        issuesCV?.refreshControl  = refreshControl
        let bundlePath = Bundle.main.path(forResource: "YES", ofType: "png")
        localizationImage.image = UIImage(contentsOfFile: bundlePath!)
        loadingView.isHidden = false
        reloadData()

    }
    
    
    func reloadData() -> Void {
                dataRequest = AF.request("http://epic-demo.com/nour/services/issue?order=desc", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil, interceptor: nil).responseString { (response) in
                    self.issuesCV?.refreshControl?.endRefreshing()
        //            print(response.value as! [Dictionary<String,AnyObject>])
                    
        //            let data = response.value?.data(using: .utf8)!
        //            do{
        //            let jsonArray = try JSONSerialization.jsonObject(with: data!, options : .allowFragments) as? [Dictionary<String,Any>]
        //            }catch{
        //                print(error.localizedDescription)
        //            }
                    
                    self.loadingView.isHidden = true
                    if let _ = response.error{
                        print("\(response.error!.errorDescription!.contains("The Internet connection appears to be offline"))" )
                        return
                    }
                  
                    if(response.response!.statusCode == 200){

                        do {
                            self.issues = try JSONDecoder().decode([Issue].self, from: response.data!)
                            self.issuesCV?.reloadData()
                            
                        } catch  {
                            print(error.localizedDescription)
                        }
                        
                        
                    }else {
                        
                    }
                    
                }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if #available(iOS 13.0, *) {
            print((self.view.window?.windowScene?.delegate as! SceneDelegate).window!)
        } else {
            print((UIApplication.shared.delegate as! AppDelegate).window!)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    func cancelAllSession(){
        Alamofire.Session.default.session.getTasksWithCompletionHandler { (sessionDataTask, uploadData, downloadData) in
            sessionDataTask.forEach( { $0.cancel() })
            downloadData.forEach( { $0.cancel() })
            }
    }
    
    
    @objc func handleRegister(sender: UIButton){
            self.issues.remove(at: 0)
            self.issuesCV?.deleteItems(at: [IndexPath(row: sender.tag, section: 0)])
            for i in 0 ... (issues.count - 1){
                (self.issuesCV?.cellForItem(at: IndexPath(row: i, section: 0)) as! IssueCell).deleteIssue.tag = i
            }
        }
}
    

extension String {
    
    func localized()-> String {
        return self.localized(comment: "")
    }
    func localized(comment : String)-> String {
        return NSLocalizedString(self, comment: comment)
    }
    
}

