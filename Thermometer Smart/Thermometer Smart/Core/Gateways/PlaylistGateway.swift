//
//  PlaylistGateway.swift
//  FoxLive
//
//  Created by HOANPV on 10/5/18.
//  Copyright © 2018 HOANDHTB. All rights reserved.
//

import UIKit

typealias FetchPlaylistEntityHandler = (_ playlist: Result<ListPlayEntity>) -> Void

protocol PlaylistGateway {
    func fetchPlaylist(paramester: PlaylistParamester,completetionHandler: @escaping FetchPlaylistUseCaseCompletionHandler)
}
