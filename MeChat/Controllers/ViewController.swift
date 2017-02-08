//
//  ViewController.swift
//  MeChat
//
//  Created by cimimorio on 2017/2/7.
//  Copyright © 2017年 yuxiao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var passwordLabel: UITextField!
    @IBOutlet weak var accountLabel: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func loginBtnClicked(_ sender: Any) {
        IMChatManager.share().mLogin(withAccount: accountLabel.text, andToken: passwordLabel.text) { [weak self](error) in
            if error != nil{
                print(error ?? "ssss")
            }else{
                print("no error")
                let mainSB = UIStoryboard.init(name: "Main", bundle: Bundle.main)
                guard let chatVC:ChatViewController = mainSB.instantiateViewController(withIdentifier: "ChatViewController") as? ChatViewController else{
                    return
                }
                self?.present(chatVC, animated: true, completion: { 
                    
                })
            }
        }
    }
}

