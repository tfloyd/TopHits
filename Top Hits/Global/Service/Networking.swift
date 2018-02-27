//
//  Networking.swift
//  Top Hits
//
//  Created by Jeff Tabios on 26/02/2018.
//  Copyright © 2018 Jeff Tabios. All rights reserved.
//

import Foundation

class Networking{
    
    private let cache = NSCache<NSString, NSData>()
    static let shared = Networking()
    
    private init(){}
    
    //Gets data from a url
    func getData(url:URL,completion:@escaping(Data) -> Void){
        
        let task = URLSession.shared.dataTask(with: url){ (data, response, err) in
            
            guard let data = data else { return }
            
            DispatchQueue.main.async {
                
                completion(data)
                
            }
            
        }
        task.resume()
        
    }
    
}
