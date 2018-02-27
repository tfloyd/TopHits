//
//  PlayerManager.swift
//  Top Hits
//
//  Created by Jeff Tabios on 26/02/2018.
//  Copyright © 2018 Jeff Tabios. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class PlayerManager:NSObject {
    
    private let cache = NSCache<NSString, NSData>()
    static let shared = PlayerManager()
    
    var asset: AVAsset!
    var player: AVPlayer!
    var playerItem: AVPlayerItem!
    
    let nc = NotificationCenter.default
    
    var currentSongNumber: Int = -1
    var lastSongNumber: Int = -1
    
    var playerStatus = 0 //0-Stopped, 1-Playing, 2-Paused
    
    func playMusic(songNumber: Int) {
        
        if currentSongNumber != songNumber {
            
            lastSongNumber = currentSongNumber
            
            currentSongNumber = songNumber
            
            nc.post(name: Notification.Name("SongChosen"), object: nil)
            
            let url: URL = songList[currentSongNumber].audioLink!
            let asset = AVAsset(url: url)
            playerItem = AVPlayerItem(asset: asset)
            
            nc.addObserver(self, selector: #selector(playerDidFinishPlaying), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)

            player = AVPlayer(playerItem: playerItem)
            
        }else{
            nc.post(name: Notification.Name("SongResumed"), object: nil)
        }
        
        player.play()
        
        playerStatus=1
        
    }
    
    func pauseMusic() {
        player.pause()
        
        playerStatus=2
        nc.post(name: Notification.Name("SongPaused"), object: nil)
        
    }
    
    
    @objc func playerDidFinishPlaying(){
        currentSongNumber = -1
        
        playerStatus=0
        nc.post(name: Notification.Name("SongFinished"), object: nil)
        
        print(currentSongNumber)
    }
    
}
