//
//  PlayerVC.swift
//  Top Hits
//
//  Created by Jeff Tabios on 26/02/2018.
//  Copyright © 2018 Jeff Tabios. All rights reserved.
//

import UIKit
import CoreMedia

class PlayerVC: UIViewController {

    @IBOutlet weak var SongImage: UIImageView!
    @IBOutlet weak var SongBGImage: UIImageView!
    
    @IBOutlet weak var SongTitle: UILabel!
    @IBOutlet weak var SongAuthor: UILabel!
    
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    
    
    
    let playerManager = PlayerManager.shared
    var currentSongNumber = PlayerManager.shared.currentSongNumber
    var status = PlayerManager.shared.playerStatus
    var player = PlayerManager.shared.player
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        
        setUp()
    }
    
    func setUp(){
        if status==1 {
            pauseButton.isHidden = false
            playButton.isHidden = true
        }else {
            pauseButton.isHidden = true
            playButton.isHidden = false
        }
        
        self.SongTitle.text = songList[currentSongNumber].name
        self.SongAuthor.text = songList[currentSongNumber].author?.name
        
        let songImageUrl = songList[currentSongNumber].picture?.s
        PlayerNetworking.shared.getImage(url: songImageUrl!){ (image) in
            self.SongImage.image = image
            self.SongBGImage.image = image
        }
        
    }
    
    
    @IBAction func playPushed(_ sender: Any) {
        playerManager.playMusic(songNumber: currentSongNumber)
        
            pauseButton.isHidden = false
            playButton.isHidden = true
        
    }
    
    @IBAction func pausePushed(_ sender: Any) {
        playerManager.pauseMusic()
        
            pauseButton.isHidden = true
            playButton.isHidden = false
        
        print("paused")
    }
    
    @IBAction func nextPushed(_ sender: Any) {
        if currentSongNumber == songList.count - 1 {
            currentSongNumber = 0
        }else {
            currentSongNumber=currentSongNumber+1
        }
        PlayerManager.shared.pauseMusic()
        PlayerManager.shared.playMusic(songNumber: currentSongNumber)
        setUp()
    }
    
    @IBAction func prevPushed(_ sender: Any) {
        
        let t1 = Float(PlayerManager.shared.player.currentTime().value)
        let t2 = Float(PlayerManager.shared.player.currentTime().timescale)
        let currentSeconds = t1 / t2
        
        print(currentSeconds)
        
        //If less than 3 seconds then play prev otherwise rewind
        if currentSeconds < 3 {
            if currentSongNumber == 0 {
                currentSongNumber = songList.count - 1
            }else {
                currentSongNumber=currentSongNumber-1
            }
             PlayerManager.shared.pauseMusic()
            playerManager.playMusic(songNumber: currentSongNumber)
            setUp()
        }else{
            
            playerManager.currentSongNumber = -1
            playerManager.lastSongNumber = -1
            //currentSongNumber = playerManager.currentSongNumber
            
             PlayerManager.shared.pauseMusic()
            playerManager.playMusic(songNumber: currentSongNumber)
            setUp()
        }
        
    }
    
    @IBAction func Back(_ sender: Any) {

        navigationController?.popViewController(animated: true)
    }
}
