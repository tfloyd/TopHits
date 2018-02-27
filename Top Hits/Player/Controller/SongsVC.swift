//
//  ViewController.swift
//  Top Hits
//
//  Created by Jeff Tabios on 26/02/2018.
//  Copyright © 2018 Jeff Tabios. All rights reserved.
//

import UIKit

//Global
var songList = [Song]()

class SongsVC: UIViewController {

    //Mini-Player Outlets
    @IBOutlet weak var MPPlayButton: UIBarButtonItem!
    @IBOutlet weak var MPPauseButton: UIBarButtonItem!
    @IBOutlet weak var MPMoreButton: UIBarButtonItem!
    @IBOutlet weak var MPMoreButton2: UIBarButtonItem!
    
    @IBOutlet weak var MPSongTitle: UILabel!
    @IBOutlet weak var MPAuthor: UILabel!
    
    //Table outlet
    @IBOutlet weak var songsTable: UITableView!
    @IBOutlet weak var toolbarView: UIView!
    
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var toolbarPlaying: UIToolbar!
    
    let nc = PlayerManager.shared.nc
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PlayerNetworking.getSongs() { (songs) in
            songList = songs.data!
            self.songsTable.reloadData()
        }
        
        nc.addObserver(self, selector: #selector(setPlayingStatus), name: Notification.Name("SongChosen"), object: nil)
        
        nc.addObserver(self, selector: #selector(setPausedStatus), name: Notification.Name("SongPaused"), object: nil)
        
        nc.addObserver(self, selector: #selector(setFinishedStatus), name: Notification.Name("SongFinished"), object: nil)
        
        
    }
    
    
    //MiniPlayer actions
    @IBAction func MPPlayPushed(_ sender: Any) {
        PlayerManager.shared.playMusic(songNumber: PlayerManager.shared.currentSongNumber)
        
        toolbar.isHidden = true
        toolbarPlaying.isHidden = false
    }
    
    @IBAction func MPPausePushed(_ sender: Any) {
        PlayerManager.shared.pauseMusic()
        
        toolbar.isHidden = false
        toolbarPlaying.isHidden = true
        
    }
    
    @IBAction func MPMorePushed(_ sender: Any) {
        self.performSegue(withIdentifier: "SongDetailSeque", sender: self)
    }
    
    @IBAction func MPMore2Pushed(_ sender: Any) {
        self.performSegue(withIdentifier: "SongDetailSeque", sender: self)
    }
    
    
}


extension SongsVC{
    
    @objc func setFinishedStatus(){
        toolbarView.isHidden = true
    }
    
    @objc func setPausedStatus(){
        toolbar.isHidden = false
        toolbarPlaying.isHidden = true
        toolbarView.isHidden = false
    }

    @objc func setPlayingStatus(){
        
        //Show Mini Player
        toolbarView.isHidden = false
        toolbar.isHidden = true //Toolbar with Pay button
        toolbarPlaying.isHidden = false
        
        //Set current to play image
        let currentSongNumber = PlayerManager.shared.currentSongNumber
        
        MPSongTitle.text = songList[currentSongNumber].name
        MPAuthor.text = songList[currentSongNumber].author?.name
        
        
        //Disabled Pausing in table cell due to rendering issue
        
        //guard let currentCell = songsTable.cellForRow(at: IndexPath(row: currentSongNumber, section: 0)) as? SongItemCell else { return }
        //currentCell.bigPlayButton.isHidden = true
        //currentCell.bigPauseButton.isHidden = false
        
        //MPSongTitle.text = songList[currentSongNumber].name
        //MPAuthor.text = songList[currentSongNumber].author?.name
        
        //toolbarView.isHidden = false
        //toolbarPlaying.isHidden = false
        
        //let lastSongNumber = PlayerManager.shared.lastSongNumber
        //print("last playing:",lastSongNumber)
        
        //Reset last playing/paused to play image
        //guard let lastCell = songsTable.cellForRow(at: IndexPath(row: PlayerManager.shared.lastSongNumber, section: 0)) as? SongItemCell else { return }
        //lastCell.bigPlayButton.isHidden = false
        //lastCell.bigPauseButton.isHidden = true
        
        
    }
    
    
    
}

//Table functions
extension SongsVC: UITableViewDataSource,UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell") as? SongItemCell else {
            return UITableViewCell()
        }
        
        let songImageUrl = songList[indexPath.row].picture?.s
        PlayerNetworking.shared.getImage(url: songImageUrl!){ (image) in
            cell.songImage.image = image
        }
        
        let authorImageUrl = songList[indexPath.row].author?.picture?.xs
        PlayerNetworking.shared.getImage(url: authorImageUrl!){ (image) in
            cell.authorImage.image = image
        }
        
        cell.songTitle.text = songList[indexPath.row].name
        cell.songAuthor.text = songList[indexPath.row].author?.name
        
        cell.authorName.text = songList[indexPath.row].author?.name
        
        cell.bigPlayButton.tag = indexPath.row
        cell.bigPauseButton.isHidden = true
        
        cell.indexPath = indexPath
        
        return cell
        
    }
    
    
}

