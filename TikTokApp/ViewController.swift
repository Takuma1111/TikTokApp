//
//  ViewController.swift
//  TickTockApp
//
//  Created by 村上拓麻 on 2020/08/16.
//  Copyright © 2020 村上拓麻. All rights reserved.
//

import UIKit
import AVFoundation

//Fat View Controller😭
class ViewController: UIViewController {

    var heartLabel : UILabel!
    private var heartJudge : Bool = true
    private var heartCount : Int = 1999
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //動画再生呼び出し
        movieStart()
        //UI生成呼び出し
        UIScript()
        //icon生成呼び出し
        icon()
    }

    private func movieStart(){
        
        //Play Video
        let path =  Bundle.main.path(forResource: "IMG_2227", ofType: "MOV")!
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        player.play()
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 80)
        playerLayer.videoGravity = .resizeAspectFill
        playerLayer.zPosition = -1 // ボタン等よりも後ろに表示
        view.layer.insertSublayer(playerLayer, at: 0) // 動画をレイヤーとして追加
    }
    
    //thx
    //https://qiita.com/tattn/items/499b5f49fb11f55b3df7
    private func UIScript(){
        //Heart Count Label
        heartLabel = UILabel(frame: CGRect(x: 170, y: view.frame.height - 365, width: view.frame.width - 40, height: 30))
        heartLabel.text = String(heartCount)
        heartLabel.textColor = .white
        heartLabel.font = UIFont.boldSystemFont(ofSize: 15)
        heartLabel.textAlignment = .center
        heartLabel.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        view.addSubview(heartLabel)

        //Chat Count Label
        let chatLabel = UILabel(frame: CGRect(x: 170, y: view.frame.height - 285, width: view.frame.width - 40, height: 30))
        chatLabel.text = "1998"
        chatLabel.textColor = .white
        chatLabel.font = UIFont.boldSystemFont(ofSize: 15)
        chatLabel.textAlignment = .center
        chatLabel.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        view.addSubview(chatLabel)
        
        //Share Count Label
        let shareLabel = UILabel(frame: CGRect(x: 170, y: view.frame.height - 205, width: view.frame.width - 40, height: 30))
        shareLabel.text = "2020"
        shareLabel.textColor = .white
        shareLabel.font = UIFont.boldSystemFont(ofSize: 15)
        shareLabel.textAlignment = .center
        shareLabel.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        view.addSubview(shareLabel)
        
        //Company Name Label    100
        let comLabel = UILabel(frame: CGRect(x:-100, y: view.frame.height - 180, width:  view.frame.width - 40, height: 30))
        comLabel.text = "@TinTin Japan"
        comLabel.textColor = .white
        comLabel.font = UIFont.boldSystemFont(ofSize: 20)
        comLabel.textAlignment = .center
        comLabel.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        view.addSubview(comLabel)
        
        let userNameLabel = UILabel(frame: CGRect(x:-115, y: view.frame.height - 145, width:  view.frame.width - 40, height: 30))
        userNameLabel.text = "tintin your X"
        userNameLabel.textColor = .white
        userNameLabel.font = UIFont.boldSystemFont(ofSize: 15)
        userNameLabel.textAlignment = .center
        userNameLabel.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        view.addSubview(userNameLabel)
        
        
        let soundNameLabel = UILabel(frame: CGRect(x:-45, y: view.frame.height - 120, width:  view.frame.width - 40, height: 30))
        soundNameLabel.text = "♫ オリジナル楽曲 - TinTin Japan"
        soundNameLabel.textColor = .white
        soundNameLabel.font = UIFont.boldSystemFont(ofSize: 15)
        soundNameLabel.textAlignment = .center
      
        soundNameLabel.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        view.addSubview(soundNameLabel)
        
        //Button Image
        let heartImage = UIImage(named: "ハートのアイコン素材 1") as UIImage?
        let chatImage = UIImage(named: "コメントのアイコン素材 その3 (1)") as UIImage?
        let shareImage = UIImage(named: "シェア矢印アイコン") as UIImage?
        
        //Heart Button
        let heartButton = UIButton(frame: .init(x: 317, y: view.frame.height - 400, width: 40, height: 40))
        heartButton.setImage(heartImage, for: .normal)
        heartButton.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        heartButton.addTarget(self, action: #selector(heartButtonEvent(_:)), for: UIControl.Event.touchUpInside)
        view.addSubview(heartButton)
        
        //Chat Button
        let chatButton = UIButton(frame: .init(x:317,y: view.frame.height - 320, width:40, height: 40))
        chatButton.setImage(chatImage, for: .normal)
        chatButton.autoresizingMask = [.flexibleWidth,.flexibleTopMargin]
        chatButton.addTarget(self, action: #selector(commentButtonEvent(_:)), for: UIControl.Event.touchUpInside)
        view.addSubview(chatButton)
        
        //Share Button
        let shareButton = UIButton(frame: .init(x:320,y: view.frame.height - 240, width: 40, height: 40))
        shareButton.setImage(shareImage, for: .normal)
        shareButton.autoresizingMask = [.flexibleWidth,.flexibleTopMargin]
        shareButton.addTarget(self, action: #selector(shareButtonEvent(_:)), for: UIControl.Event.touchUpInside)
        view.addSubview(shareButton)
    }
    
    private func icon(){
        //バナナアイコン
        let iconImage = UIImage(named: "E38390E3838AE3838A") as UIImage?
        let imageView = UIImageView(image:iconImage)
        imageView.frame = CGRect(x:310, y:330, width:50, height:50)
        let imageLength = CGFloat(50)
        imageView.layer.cornerRadius = imageLength * 0.5 //1辺の長さ * 0.5にする
        imageView.clipsToBounds = true
        
        //＋画像
        let plusImage = UIImage(named: "スクリーンショット 2020-08-16 20.48.19") as UIImage?
        let imageView2 = UIImageView(image: plusImage)
        imageView2.frame = CGRect(x:320, y:363, width:30, height:30)
        imageView2.layer.cornerRadius = imageLength * 0.5 //1辺の長さ * 0.5にする
        imageView2.clipsToBounds = true
        
        //回るバナナアイコン
        let musicIcon = UIImage(named: "スクリーンショット 2020-08-16 22.16.42") as UIImage?
        let imageView3 = UIImageView(image: musicIcon)
        imageView3.frame = CGRect(x:315, y:670, width:50, height:50)
        let rollingAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rollingAnimation.fromValue = 0
        rollingAnimation.toValue = CGFloat.pi * 2.0
        rollingAnimation.duration = 8.0 // 周期２秒
        rollingAnimation.repeatDuration = CFTimeInterval.infinity // 無限に
        imageView3.layer.add(rollingAnimation, forKey: "rollingImage") // アニメーションを追加
       // 設定した画像をスクリーンに表示する
        self.view.addSubview(imageView)
        self.view.addSubview(imageView2)
        self.view.addSubview(imageView3)
    }
    
    // ボタンが押された時に呼ばれるメソッド
    @objc func heartButtonEvent(_ sender: UIButton) {
        let redHeartImage = UIImage(named: "RedHeart") as UIImage?
        let whiteHeartImage = UIImage(named: "ハートのアイコン素材 1") as UIImage?
        
        if(heartJudge){
            sender.setImage(redHeartImage, for: .normal)
            heartJudge = false
            heartCount += 1
            heartLabel.text = String(heartCount)
        }else{
            sender.setImage(whiteHeartImage, for: .normal)
            heartJudge = true
            heartCount -= 1
            heartLabel.text = String(heartCount)
        }
    }
    
    @objc func commentButtonEvent(_ sender: UIButton) {
        let vc = SemiModalViewController.make()
              present(vc, animated: true, completion: nil)
    }
    @objc func shareButtonEvent(_ sender: UIButton) {
          let vc = ShareViewController.make()
                present(vc, animated: true, completion: nil)
      }
}

