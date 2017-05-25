import MediaPlayer

class MPUserMediaPlayer {
    
    func getPlaylists() {
        MPMediaLibrary.requestAuthorization { auth in
            switch auth {
            case .denied:
                fatalError()
            case .notDetermined:
                return
            case .restricted:
                return
            case .authorized:
                let myPlaylistQuery = MPMediaQuery.playlists()
                let myPodcastsQuery = MPMediaQuery.podcasts()
                let myMusicQuery = MPMediaQuery.songs()
                let playlists = myPlaylistQuery.collections
                let podcasts = myPodcastsQuery.collections
                guard let newPodcasts = podcasts else { return }
                
                for podcast in newPodcasts {
                    print(podcast.value(forProperty: MPMediaPlaylistPropertyName))
                    let songs = podcast.items
                    for song in songs {
                        let songTitle = song.value(forProperty: MPMediaItemPropertyTitle)
                        print("\t\t", songTitle!)
                    }
                }
                
                guard let newPlaylists = playlists else { return }
                for playlist in newPlaylists {
                    print(playlist.value(forProperty: MPMediaPlaylistPropertyName))
                    let songs = playlist.items
                    for song in songs {
                        let songTitle = song.value(forProperty: MPMediaItemPropertyTitle)
                        print("\t\t", songTitle!)
                    }
                }
            }
            
        }
        
    }
}
