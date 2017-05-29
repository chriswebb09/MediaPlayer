//
//  Playlist.swift
//  MediaPlayer
//
//  Created by Christopher Webb-Orenstein on 5/19/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import Foundation

protocol DataCollection { }

public class Playlist: DataCollection {
    
    private var head: PlaylistItem?
    
    var itemCount: Int = 0
    
    var isEmpty: Bool? {
        return head == nil
    }
    
    private var last: PlaylistItem? {
        if var track = head {
            while case let next? = track.next {
                track = next
            }
            return track
        } else {
            return nil
        }
    }
    
    func append(newPlaylistItem: PlaylistItem?) {
        itemCount += 1
        if let lastItem = last {
            newPlaylistItem?.previous = lastItem
            lastItem.next = newPlaylistItem
        } else if head == nil {
            head = newPlaylistItem
        }
    }
    
    func printAllKeys() {
        var current: PlaylistItem! = head
        var i = 1
        while current != nil {
            i += 1
            current = current.next
        }
    }
    
    func playlistItem(at index: Int) -> PlaylistItem? {
        
        if index >= 0 {
            var trackItem = head
            var i = index
            while let trackAt = trackItem, trackItem != nil {
                if i == 0 {
                    return trackAt
                }
                i -= 1
                trackItem = trackAt.next
            }
        }
        return nil
    }
    
    func reverse() {
        var track = head
        while let currentTrack = track {
            track = currentTrack.next
            swap(&currentTrack.next, &currentTrack.previous)
            head = currentTrack
        }
    }
    
    func removeFromPlaylist(for playlistItem: PlaylistItem?) -> Track? {
        let previous = playlistItem?.previous
        let next = playlistItem?.next
        
        if let previous = previous {
            previous.next = next
        } else {
            head = next
        }
        next?.previous = previous
        
        playlistItem?.previous = nil
        playlistItem?.next = nil
        guard let trackItem = playlistItem?.track else { return nil }
        return trackItem
    }
    
    func removeAll() {
        var track = head
        
        while let next = track?.next {
            track?.previous = nil
            track = nil
            track = next
        }
        head = nil
        itemCount = 0
    }
    
    func removeNodesFromList() {
        
    }
    
    func contains(playlistItem item: PlaylistItem) -> Bool {
        guard let currentTrack = head else { return false }
        while currentTrack != item && currentTrack.next != nil {
            guard let currentTrack = currentTrack.next else { return false }
            if currentTrack == item {
                return true
            }
        }
        return false
    }
}
