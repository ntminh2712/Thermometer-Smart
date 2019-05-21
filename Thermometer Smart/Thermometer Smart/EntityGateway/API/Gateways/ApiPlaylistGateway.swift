//
//  ApiPlaylistGateway.swift
//  FoxLive
//
//  Created by HOANPV on 10/5/18.
//  Copyright © 2018 HOANDHTB. All rights reserved.
//

import UIKit

protocol ApiPlaylistGateway: PlaylistGateway {

}

class ApiPlaylistGatewayImplemention: ApiPlaylistGateway {
    func fetchPlaylist(paramester: PlaylistParamester, completetionHandler: @escaping (Result<ListPlayEntity>) -> Void) {
        apiProvider.request(TSAPI.searchPlayList(paramester.type, paramester.q, paramester.maxResult, paramester.part, paramester.codeRegion, paramester.pageToken)).asObservable().mapObject(ListPlayEntity.self).subscribe(onNext:{(result) in
            completetionHandler(.success(result))
        }, onError: {
            (error) in
            completetionHandler(.failure(error))
        })
    }
}
