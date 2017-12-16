//
//  SoundViewController.swift
//  MousouLine
//
//  Created by saito-takumi on 2017/12/16.
//  Copyright © 2017年 saito-takumi. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class SoundViewController: UIViewController {
    var audioPlayer: AVAudioPlayer?
    var counter = 0 {
        didSet{
            let minute = counter / 60
            let second = counter % 60
            self.timeLabel.text = String.init(format: "%02d:%02d", minute, second)
        }
    }
    
    enum State {
        case calling
        case talking
    }
    @IBOutlet weak var talkingImageView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    
    var state :State = .calling {
        didSet {
            switch state {
            case .calling:
                talkingImageView.isHidden = true
                timeLabel.isHidden = true
                audioLoad(audioName: "callMusic")
                audioPlayer?.play()
                break
            case .talking:
                talkingImageView.isHidden = false
                timeLabel.isHidden = false
                audioLoad(audioName: "asuka")
                audioPlayer?.play()
                Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (timer) in
                    self.counter += 1
                    
                })
                break
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.state = .calling
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        audioPlayer?.stop()
    }
    
    func audioLoad(audioName: String) {
        
        // サウンドデータの読み込み。ファイル名は"kane01"。拡張子は"mp3"
        let audioPath = URL(fileURLWithPath: Bundle.main.path(forResource: audioName, ofType: "mp3")!)
        
        // swift2系からtryでエラー処理するようなので、do〜try〜catchで対応
        do {
            // AVAudioPlayerを作成。もし何かの事情で作成できなかったらエラーがthrowされる
            audioPlayer = try AVAudioPlayer(contentsOf: audioPath)
            
        }
            // playerを作成した時にエラーがthrowされたらこっち来る
        catch {
            print("AVAudioPlayer error")
        }
    }

    
    @IBAction func tapTalkButtonAction(_ sender: Any) {
        self.state = .talking
    }
    
    @IBAction func tapDenyAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
