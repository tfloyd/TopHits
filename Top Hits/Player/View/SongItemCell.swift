//
//  SongItemCellTableViewCell.swift
//  Top Hits
//
//  Created by Jeff Tabios on 26/02/2018.
//  Copyright © 2018 Jeff Tabios. All rights reserved.
//

import UIKit
import Foundation
class SongItemCell: UITableViewCell {

    @IBOutlet weak var songImage: UIImageView!
    @IBOutlet weak var songTitle: UILabel!
    @IBOutlet weak var songAuthor: UILabel!
    
    @IBOutlet weak var authorImage: UIImageView!
    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var modifiedDate: UILabel!

    @IBOutlet weak var songDetail: UIButton!
    
    @IBOutlet weak var bigPlayButton: UIButton!
    @IBOutlet weak var bigPauseButton: UIButton!
    
    @IBOutlet weak var musicDetailButton: UIButton!
    
    var indexPath = IndexPath()
    
    @IBAction func bigPlayPushed(_ sender: Any) {
        let bigButton = sender as! UIButton
        
        /*bigButton.isHidden = true
         bigPauseButton.isHidden = false
         */
        
        PlayerManager.shared.playMusic(songNumber: bigButton.tag)
            
    }
    
    @IBAction func bigPausePushed(_ sender: Any) {
        //let bigButton = sender as! UIButton
        
        PlayerManager.shared.pauseMusic()
        
        /*
         bigButton.isHidden = true
         self.bigPlayButton.isHidden = false
         */
    }
    
}
