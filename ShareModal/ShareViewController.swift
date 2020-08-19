//
//  ShareViewController.swift
//  TikTokApp
//
//  Created by 村上拓麻 on 2020/08/19.
//  Copyright © 2020 村上拓麻. All rights reserved.
//

import UIKit

class ShareViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //DefaultのViewを透明にする
        view.backgroundColor = UIColor.clear
        
        // Do any additional setup after loading the view.
    }
    
    static func make() -> ShareViewController{
          let sb = UIStoryboard(name: "ShareModalViewController", bundle: nil)
          let vc = sb.instantiateInitialViewController() as! ShareViewController
          return vc
      }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
