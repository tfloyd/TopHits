//
//  PlayerNetworking.swift
//  Top Hits
//
//  Created by Jeff Tabios on 26/02/2018.
//  Copyright © 2018 Jeff Tabios. All rights reserved.
//

import Foundation
import UIKit

class PlayerNetworking {
    
    private let cache = NSCache<NSString, NSData>()
    static let shared = PlayerNetworking()
    
    private init() {}
    
    static func getSongs(completion: @escaping(Songs) -> Void) {
        
        let jsonSongs = "https://gist.githubusercontent.com/anonymous/fec47e2418986b7bdb630a1772232f7d/raw/5e3e6f4dc0b94906dca8de415c585b01069af3f7/57eb7cc5e4b0bcac9f7581c8.json"
        
        guard let songsUrl = URL(string: jsonSongs) else { return }
        
        Networking.shared.getData(url: songsUrl) { (jsonData) in
            
            do{
                
                let songs = try JSONDecoder().decode(Songs.self,from: jsonData )
                
                completion(songs)
                
            } catch {}
            
        }
        
    }
    
    func getImage(url: URL, completion: @escaping(UIImage) -> ()) {
        
        Networking.shared.getData(url: url) { (imageData) in
            
            
            DispatchQueue.main.async {
                completion(UIImage(data: imageData as Data)!)
            
            }
            
            
        }
      
        
        /*
        DispatchQueue.global(qos: DispatchQoS.QoSClass.background).async {
            
            if let data = self.cache.object(forKey: url.absoluteString as NSString) {
                DispatchQueue.main.async { completionHandler(UIImage(data: data as Data)) }
                return
            }
            
            guard let data = NSData(contentsOf: url) else {
                DispatchQueue.main.async { completionHandler(nil) }
                return
            }
            
            self.cache.setObject(data, forKey: url.absoluteString as NSString)
            DispatchQueue.main.async { completionHandler(UIImage(data: data as Data)) }
        }
 */
    }
    
}
