//
//  DetailViewController.swift
//  RealMusic
//
//  Created by asiantech on 9/8/16.
//  Copyright © 2016 asiantech. All rights reserved.
//

import UIKit
import AVFoundation

class DetailViewController: RMViewController {

    @IBOutlet weak var customSlider: BWCircularSliderView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var songLabel: UILabel!
    @IBOutlet weak var acterLabel: UILabel!
    @IBOutlet weak var totalTimeLabel: UILabel!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var backGroundImage: UIImageView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var shuffleButton: UIButton!
    @IBOutlet weak var repeatButton: UIButton!
    
    let player = AVAudioPlayer()
    var toggleState = 1
    var songs = Song()
    
    //MARK: - Life Cycil
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func setupUI() {
        super.setupUI()
        setLayerTitle()
        addEffect()
    }
    
    override func setupData() {
        super.setupData()
    }
    
    //MARK: - Private
    
    private func setLayerTitle() {
        self.titleLabel.textColor = UIColor(red: 254.0/255.0, green: 103.0/255.0, blue: 99.0/255.0, alpha: 1)
        let color:UIColor = UIColor(red: 255.0/255.0, green: 128.0/255.0, blue: 103.0/255.0, alpha: 1)
        self.titleLabel.layer.shadowColor = color.CGColor
        
        self.titleLabel.layer.shadowOffset = CGSizeZero
        self.titleLabel.layer.shadowOpacity = 0.9
        self.titleLabel.layer.shadowRadius = 4.0
    }
    
    private func addEffect()
    {
        let mainSreen = UIScreen.mainScreen().bounds
        let effect =  UIBlurEffect(style: UIBlurEffectStyle.Dark)
        
        let effectView  = UIVisualEffectView(effect: effect)
        
        effectView.frame  = CGRectMake(0, 0, mainSreen.width, mainSreen.height)
        
        backGroundImage.addSubview(effectView)
    }
    
    
    
    //MARK: - IBAction
    @IBAction func playAction(sender: UIButton) {
        let playBtn = sender as UIButton
        if toggleState == 1 {
//            player.play()
            toggleState = 2
            playBtn.setImage(UIImage(named:"ic_bt_pause"),forState:UIControlState.Normal)
        } else {
//            player.pause()
            toggleState = 1
            playBtn.setImage(UIImage(named:"ic_bt_play"),forState:UIControlState.Normal)
        }
        
    }
    @IBAction func nextAction(sender: UIButton) {
        
    }
    @IBAction func preAction(sender: UIButton) {
        
    }
    @IBAction func shuffleAction(sender: UIButton) {
        
    }
    @IBAction func repeatAction(sender: UIButton) {
        
    }

}
