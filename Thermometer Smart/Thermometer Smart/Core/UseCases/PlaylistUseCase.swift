//
//  PlaylistUseCase.swift
//  FoxLive
//
//  Created by HOANPV on 10/5/18.
//  Copyright © 2018 HOANDHTB. All rights reserved.
//

import UIKit

typealias FetchPlaylistUseCaseCompletionHandler = (_ listItem: Result<ListPlayEntity>) -> Void

protocol PlaylistUseCase {
    func fetch(paramester: PlaylistParamester, completionHandler: @escaping FetchPlaylistUseCaseCompletionHandler)
}

struct PlaylistParamester
{
    var type: String
    var q: String
    var maxResult: Int
    var part: String
    var codeRegion:String
    var pageToken: String
}

class PlaylistUseCaseImplemention: PlaylistUseCase
{
    
    let playlistGateway: PlaylistGateway
    
    init(playlistGateway: PlaylistGateway) {
        self.playlistGateway = playlistGateway
    }
    
    func fetch(paramester: PlaylistParamester, completionHandler: @escaping FetchPlaylistUseCaseCompletionHandler) {
        self.playlistGateway.fetchPlaylist(paramester: paramester){
            (result) in
            completionHandler(result)
        }
    }
}
