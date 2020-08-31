//
//  ViewController.swift
//  TickTockApp
//
//  Created by 村上拓麻 on 2020/08/16.
//  Copyright © 2020 村上拓麻. All rights reserved.
//

import UIKit
import AVFoundation
import Firebase
//Fat View Controller😭
class ViewController: UIViewController {

    var heartLabel : UILabel!
    var chatLabel : UILabel!
    var shareLabel : UILabel!
    var comLabel : UILabel!
    var userNameLabel : UILabel!
    var soundNameLabel : UILabel!
    
    private var heartJudge : Bool = true
    private var heartCount : Int = 1999
    var playerLayer  = AVPlayerLayer()
    var player = AVPlayer()
    
    var playerLayer2  = AVPlayerLayer()
    var player2 = AVPlayer()
    
    var iconImage : UIImage?
    var musicIcon : UIImage?
    var imageView : UIImageView?
    var imageView3 : UIImageView?

    var judge : Bool = false
    
    private var user: User! //ユーザー

    override func viewDidLoad() {
        super.viewDidLoad()
        print("送信者の名前:",user?.displayName)
        print("送信者のid:",user?.uid)
        
        
        
        //動画再生呼び出し
        movieStart("マイムービー 1")
        //UI生成呼び出し
        UIScript("1998","2020","@TinTin Japan","船に乗ったお","♫ オリジナル楽曲 - TinTin Japan")
        //icon生成呼び出し
        icon()
    }

    @IBAction func upSwiped(_ sender: Any) {
        print("スワイプした")
        playerLayer.removeFromSuperlayer()
        heartCount = 204
        heartLabel.text = String(heartCount)
        chatLabel.text = "554"
        shareLabel.text = "142"
        comLabel.text = "@🤮🤮🤮☀️"
        userNameLabel.text = "江ノ島行った"
        soundNameLabel.text = "♫ オリジナル楽曲 - 🤮🤮🤮☀️"
        imageView?.image = UIImage(named: "tabacoIcon")
        imageView3?.image = UIImage(named: "tabaco")
        movieStart("IMG_2182")


        if(judge){
            heartCount = 1999
            heartLabel.text = String(heartCount)
            chatLabel.text = "1998"
            shareLabel.text = "2020"
            comLabel.text = "@TinTin Japan"
            userNameLabel.text = "船に乗ったお"
            soundNameLabel.text = "♫ オリジナル楽曲 - TinTin Japan"
            imageView?.image = UIImage(named: "E38390E3838AE3838A")
            imageView3?.image = UIImage(named: "スクリーンショット 2020-08-16 22.16.42")
            playerLayer.removeFromSuperlayer()
            movieStart("マイムービー 1")
        }
        judge = true

    }
    private func movieStart(_ video_path : String){
        
        //Play Video
        let path =  Bundle.main.path(forResource: video_path, ofType: "mov")!
        player = AVPlayer(url: URL(fileURLWithPath: path))
        player.play()
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 80)
        playerLayer.videoGravity = .resizeAspectFill
        playerLayer.zPosition = -1 // ボタン等よりも後ろに表示
        // 動画の終了時に巻き戻し再生する
        NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidReachEnd(_:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
        view.layer.insertSublayer(playerLayer, at: 0) // 動画をレイヤーとして追加
        
    }

    
    //thx
    //https://qiita.com/tattn/items/499b5f49fb11f55b3df7
    private func UIScript(_ chat:String, _ share:String,_ com:String,_ user:String,_ sound:String){
        //Heart Count Label
        heartLabel = UILabel(frame: CGRect(x: 170, y: view.frame.height - 365, width: view.frame.width - 40, height: 30))
        heartLabel.text = String(heartCount)
        heartLabel.textColor = .white
        heartLabel.font = UIFont.boldSystemFont(ofSize: 15)
        heartLabel.textAlignment = .center
        heartLabel.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        view.addSubview(heartLabel)

        //Chat Count Label
        chatLabel = UILabel(frame: CGRect(x: 170, y: view.frame.height - 285, width: view.frame.width - 40, height: 30))
        chatLabel.text = chat
        chatLabel.textColor = .white
        chatLabel.font = UIFont.boldSystemFont(ofSize: 15)
        chatLabel.textAlignment = .center
        chatLabel.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        view.addSubview(chatLabel)
        
        //Share Count Label
        shareLabel = UILabel(frame: CGRect(x: 170, y: view.frame.height - 205, width: view.frame.width - 40, height: 30))
        shareLabel.text = share
        shareLabel.textColor = .white
        shareLabel.font = UIFont.boldSystemFont(ofSize: 15)
        shareLabel.textAlignment = .center
        shareLabel.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        view.addSubview(shareLabel)
        
        //Company Name Label    100
        comLabel = UILabel(frame: CGRect(x:-100, y: view.frame.height - 180, width:  view.frame.width - 40, height: 30))
        comLabel.text = com
        comLabel.textColor = .white
        comLabel.font = UIFont.boldSystemFont(ofSize: 20)
        comLabel.textAlignment = .center
        comLabel.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        view.addSubview(comLabel)
        
        userNameLabel = UILabel(frame: CGRect(x:-115, y: view.frame.height - 145, width:  view.frame.width - 40, height: 30))
        userNameLabel.text = user
        userNameLabel.textColor = .white
        userNameLabel.font = UIFont.boldSystemFont(ofSize: 15)
        userNameLabel.textAlignment = .center
        userNameLabel.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        view.addSubview(userNameLabel)
        
        
        soundNameLabel = UILabel(frame: CGRect(x:-45, y: view.frame.height - 120, width:  view.frame.width - 40, height: 30))
        soundNameLabel.text = sound
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
        iconImage = UIImage(named: "E38390E3838AE3838A") as UIImage?
        imageView = UIImageView(image:iconImage)
        imageView!.frame = CGRect(x:310, y:330, width:50, height:50)
        let imageLength = CGFloat(50)
        imageView!.layer.cornerRadius = imageLength * 0.5 //1辺の長さ * 0.5にする
        imageView!.clipsToBounds = true
        
        //＋画像
        let plusImage = UIImage(named: "スクリーンショット 2020-08-16 20.48.19") as UIImage?
        let imageView2 = UIImageView(image: plusImage)
        imageView2.frame = CGRect(x:320, y:363, width:30, height:30)
        imageView2.layer.cornerRadius = imageLength * 0.5 //1辺の長さ * 0.5にする
        imageView2.clipsToBounds = true
        
        //回るバナナアイコン
        musicIcon = UIImage(named: "スクリーンショット 2020-08-16 22.16.42") as UIImage?
        imageView3 = UIImageView(image: musicIcon)
        imageView3!.frame = CGRect(x:315, y:670, width:50, height:50)
        let rollingAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rollingAnimation.fromValue = 0
        rollingAnimation.toValue = CGFloat.pi * 2.0
        rollingAnimation.duration = 8.0 // 周期２秒
        rollingAnimation.repeatDuration = CFTimeInterval.infinity // 無限に
        imageView3!.layer.add(rollingAnimation, forKey: "rollingImage") // アニメーションを追加
       // 設定した画像をスクリーンに表示する
        self.view.addSubview(imageView!)
        self.view.addSubview(imageView2)
        self.view.addSubview(imageView3!)
    }
    
    // 動画終了時に動画をループする
    @objc private func playerItemDidReachEnd(_ notification: Notification) {
        // 動画を最初に巻き戻す
        playerLayer.player?.currentItem?.seek(to: CMTime.zero, completionHandler: nil)
        player.play()
    }
    
    // 動画終了時に動画をループする
      @objc private func playerItemDidReachEnd2(_ notification: Notification) {
          // 動画を最初に巻き戻す
          playerLayer2.player?.currentItem?.seek(to: CMTime.zero, completionHandler: nil)
          player2.play()
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

