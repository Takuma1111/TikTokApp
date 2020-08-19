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
    @IBOutlet weak var backgroundView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        //DefaultのViewを透明にする
        view.backgroundColor = UIColor.clear
        //Viewに丸みをつける
        backgroundView.layoutIfNeeded()
        backgroundView.clipsToBounds = true
        backgroundView.layer.cornerRadius = 10
        
        scrollView.delegate = self
    }
    
    static func make() -> ShareViewController{
          let sb = UIStoryboard(name: "ShareModalViewController", bundle: nil)
          let vc = sb.instantiateInitialViewController() as! ShareViewController
          return vc
      }

      //一度だけメニュー作成をするためのフラグ
        var didPrepareMenu = false

        //タブの横幅
        let tabLabelWidth:CGFloat = 100

        //viewDidLoad等で処理を行うと
        //scrollViewの正しいサイズが取得出来ません
        override func viewDidLayoutSubviews() {

            //viewDidLayoutSubviewsはviewDidLoadと違い
            //何度も呼ばれてしまうメソッドなので
            //一度だけメニュー作成を行うようにします
            if didPrepareMenu { return }
            didPrepareMenu = true

            //scrollViewのDelegateを指定
            scrollView.delegate = self

            //タブのタイトル
            let titles = ["月","火","水","木","金","土","日"] //タブのタイトル

            //image Array
            let imageArray = [UIImage(named: "facebookicon") as UIImage?,UIImage(named: "instagramicom") as UIImage?,UIImage(named: "lineicon") as UIImage?,UIImage(named: "twittericon") as UIImage?,UIImage(named: "messangericon") as UIImage?]
            //タブの縦幅(UIScrollViewと一緒にします)
            let tabLabelHeight:CGFloat = scrollView.frame.height

            //右端にダミーのUILabelを置くことで
            //一番右のタブもセンターに持ってくることが出来ます
            let dummyLabelWidth = scrollView.frame.size.width/10 - tabLabelWidth/10
            let headDummyLabel = UILabel()
            
            let button = UIButton()
            
            button.frame = CGRect(x:0, y:0, width:dummyLabelWidth, height:tabLabelHeight)
//            headDummyLabel.frame = CGRect(x:0, y:0, width:dummyLabelWidth, height:tabLabelHeight)
//            scrollView.addSubview(headDummyLabel)
            scrollView.addSubview(button)
            //タブのx座標．
            //ダミーLabel分，はじめからずらしてあげましょう．
            var originX:CGFloat = dummyLabelWidth
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

            //左端にダミーのUILabelを置くことで
            //一番左のタブもセンターに持ってくることが出来ます
            let tailLabel = UILabel()
            tailLabel.frame = CGRect(x:originX, y:0, width:dummyLabelWidth, height:tabLabelHeight)
            scrollView.addSubview(tailLabel)

            //ダミーLabel分を足して上げましょう
            originX += dummyLabelWidth

            //scrollViewのcontentSizeを，タブ全体のサイズに合わせてあげる(ここ重要！)
            //最終的なoriginX = タブ全体の横幅 になります
            scrollView.contentSize = CGSize(width:originX, height:tabLabelHeight)
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
