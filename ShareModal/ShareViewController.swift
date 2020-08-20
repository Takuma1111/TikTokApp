//
//  ShareViewController.swift
//  TikTokApp
//
//  Created by 村上拓麻 on 2020/08/19.
//  Copyright © 2020 村上拓麻. All rights reserved.
//

import UIKit

class ShareViewController: UIViewController,UIScrollViewDelegate{

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var bottomScrollView: UIScrollView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var barView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var flagImage: UIButton!
    @IBOutlet weak var brokeHeartImage: UIButton!
    @IBOutlet weak var downloadImage: UIButton!
    @IBOutlet weak var saveImage: UIButton!
    //一度だけメニュー作成をするためのフラグ
    var didPrepareMenu = false
      //タブの横幅
      let tabLabelWidth:CGFloat = 100

    override func viewDidLoad() {
        super.viewDidLoad()
        
        topView.backgroundColor = UIColor.white
        
        //UIViewを背面に配置
        view.sendSubviewToBack(topView)
        //DefaultのViewを透明にする
        view.backgroundColor = UIColor.clear
        //Viewに丸みをつける
        backgroundView.layoutIfNeeded()
        backgroundView.clipsToBounds = true
        backgroundView.layer.cornerRadius = 10
        
        //bar View
        let barViewLength = CGFloat(50)
        barView.layer.borderWidth = 0.1
        barView.layer.cornerRadius = barView.frame.height / 2
        barView.clipsToBounds = true
        barView.backgroundColor = UIColor.lightGray
        
        //setting icon
        let imageLength = CGFloat(50)
        iconImage.image = UIImage(named: "IMG_0087.JPG") as UIImage?
        iconImage.layer.borderWidth = 0.1
        iconImage.layer.cornerRadius = iconImage.frame.height / 2
        iconImage.clipsToBounds = true
        
        //flag image
        flagImage.layer.borderWidth = 0.1
        flagImage.layer.cornerRadius = flagImage.frame.height / 2
        flagImage.clipsToBounds = true
        flagImage.backgroundColor = UIColor.lightGray

        
        //heart image
        brokeHeartImage.layer.borderWidth = 0.1
        brokeHeartImage.layer.cornerRadius = brokeHeartImage.frame.height / 2
        brokeHeartImage.clipsToBounds = true
        brokeHeartImage.backgroundColor = UIColor.lightGray
        
        //download Image
        downloadImage.layer.borderWidth = 0.1
        downloadImage.layer.cornerRadius = downloadImage.frame.height / 2
        downloadImage.clipsToBounds = true
        downloadImage.backgroundColor = UIColor.lightGray
        
        //save Image
        saveImage.layer.borderWidth = 0.1
        saveImage.layer.cornerRadius = saveImage.frame.height / 2
        saveImage.clipsToBounds = true
        saveImage.backgroundColor = UIColor.lightGray
        
        //setting moreButton
        moreButton.layer.borderWidth = 0.1
        moreButton.layer.cornerRadius = moreButton.frame.height / 2
//        let buttonLength = CGFloat(50)
//        moreButton.layer.cornerRadius = buttonLength * 0.5
        moreButton.backgroundColor = UIColor.lightGray
        moreButton.clipsToBounds = true
        
        scrollView.delegate = self
        bottomScrollView.delegate = self
    }
    
    static func make() -> ShareViewController{
          let sb = UIStoryboard(name: "ShareModalViewController", bundle: nil)
          let vc = sb.instantiateInitialViewController() as! ShareViewController
          return vc
      }

        //viewDidLoad等で処理を行うと
        //scrollViewの正しいサイズが取得出来ません
        override func viewDidLayoutSubviews() {

            //viewDidLayoutSubviewsはviewDidLoadと違い
            //何度も呼ばれてしまうメソッドなので
            //一度だけメニュー作成を行うようにします
            if didPrepareMenu { return }
            didPrepareMenu = true

            //タブのタイトル
            let titles = ["月","火","水","木","金","土","日"] //タブのタイトル

            //image Array
            let imageArray = [UIImage(named: "facebookicon") as UIImage?,UIImage(named: "instagramicom") as UIImage?,UIImage(named: "lineicon") as UIImage?,UIImage(named: "twittericon") as UIImage?,UIImage(named: "messangericon") as UIImage?]
            //タブの縦幅(UIScrollViewと一緒にします)
            let tabLabelHeight:CGFloat = scrollView.frame.height
            let bottomHeight:CGFloat = bottomScrollView.frame.height
            //右端にダミーのUILabelを置くことで
            //一番右のタブもセンターに持ってくることが出来ます
            let dummyLabelWidth = scrollView.frame.size.width/10 - tabLabelWidth/10
            let bottomScroll = bottomScrollView.frame.size.width/10 - bottomHeight/10
            
            let headDummyLabel = UILabel()
            
            let button = UIButton()
            let bottomButton = UIButton()
            
            bottomButton.frame = CGRect(x:0, y:0, width:bottomScroll, height:bottomHeight)
            button.frame = CGRect(x:0, y:0, width:dummyLabelWidth, height:tabLabelHeight)
//            headDummyLabel.frame = CGRect(x:0, y:0, width:dummyLabelWidth, height:tabLabelHeight)
//            scrollView.addSubview(headDummyLabel)
            scrollView.addSubview(button)
            bottomScrollView.addSubview(bottomButton)
            //タブのx座標．
            //ダミーLabel分，はじめからずらしてあげましょう．
            var originX:CGFloat = dummyLabelWidth
            var bottomOriginX:CGFloat = bottomScroll
            //titlesで定義したタブを1つずつ用意していく
            for image in imageArray {
                //タブになるUILabelを作る
//                let label = UILabel()
//                label.textAlignment = .center
//                label.frame = CGRect(x:originX, y:0, width:tabLabelWidth, height:tabLabelHeight)
//                label.text = title

                let button = UIButton()
                button.titleLabel?.textAlignment = .center
                button.frame = CGRect(x:originX, y:0, width:50, height:50)
//                button.setTitle(title, for: .normal)
                button.setTitleColor(UIColor.black, for: .normal)
                //scrollViewにぺたっとする
//                scrollView.addSubview(label)
                button.addTarget(self, action: #selector(shareButtonEvent(_:)), for: UIControl.Event.touchUpInside)
                button.setImage(image, for: .normal)

                scrollView.addSubview(button)
                //次のタブのx座標を用意する
                originX += tabLabelWidth
            }
            
            for image in imageArray {
                            //タブになるUILabelを作る
            //                let label = UILabel()
            //                label.textAlignment = .center
            //                label.frame = CGRect(x:originX, y:0, width:tabLabelWidth, height:tabLabelHeight)
            //                label.text = title

                            let button = UIButton()
                            button.titleLabel?.textAlignment = .center
                            button.frame = CGRect(x:originX, y:0, width:50, height:50)
            //                button.setTitle(title, for: .normal)
                            button.setTitleColor(UIColor.black, for: .normal)
                            //scrollViewにぺたっとする
            //                scrollView.addSubview(label)
                            button.addTarget(self, action: #selector(shareButtonEvent(_:)), for: UIControl.Event.touchUpInside)
                            button.setImage(image, for: .normal)

                            bottomScrollView.addSubview(button)
                            //次のタブのx座標を用意する
                            originX += tabLabelWidth
                        }
            
            

            //左端にダミーのUILabelを置くことで
            //一番左のタブもセンターに持ってくることが出来ます
            let tailLabel = UILabel()
            tailLabel.frame = CGRect(x:originX, y:0, width:dummyLabelWidth, height:tabLabelHeight)
            scrollView.addSubview(tailLabel)
            bottomScrollView.addSubview(tailLabel)
            //ダミーLabel分を足して上げましょう
            originX += dummyLabelWidth

            //scrollViewのcontentSizeを，タブ全体のサイズに合わせてあげる(ここ重要！)
            //最終的なoriginX = タブ全体の横幅 になります
            scrollView.contentSize = CGSize(width:originX, height:tabLabelHeight)
            bottomScrollView.contentSize = CGSize(width:originX, height:tabLabelHeight)
        }
    
        @objc func shareButtonEvent(_ sender: UIButton) {
            print(sender.titleLabel?.text)
         }

        func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
            guard scrollView == self.scrollView else { return }
            
            //微妙なスクロール位置でスクロールをやめた場合に
            //ちょうどいいタブをセンターに持ってくるためのアニメーションです

            //現在のスクロールの位置(scrollView.contentOffset.x)から
            //どこのタブを表示させたいか計算します
//            let index = Int((scrollView.contentOffset.x + tabLabelWidth/2) / tabLabelWidth)
//            let x = index * 100
//            UIView.animate(withDuration: 0.3, animations: {
//                scrollView.contentOffset = CGPoint(x:x, y:0)
//            })
        }

        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            guard scrollView == self.scrollView else { return }

            //これも上と同様に

//            let index = Int((scrollView.contentOffset.x + tabLabelWidth/2) / tabLabelWidth)
//            let x = index * 100
//            UIView.animate(withDuration: 1.0, animations: {
//                scrollView.contentOffset = CGPoint(x:x, y:0)
//            })
        }
}
