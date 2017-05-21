//
//  MediaCollectionViewController.swift
//  MediaPlayer
//
//  Created by Christopher Webb-Orenstein on 5/19/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

struct NavigationBarAttributes {
    static let navBarTint = UIColor.white
}

public class MediaCollectionViewController: BaseMediaViewController {
    
    var buttonItem: UIBarButtonItem!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    fileprivate var searchBar = UISearchBar() {
        didSet {
            searchBar.returnKeyType = .done
        }
    }
    
    
    var searchBarActive: Bool = false {
        didSet {
            if searchBarActive == true {
                navigationItem.rightBarButtonItems = []
            } else {
                if let buttonItem = buttonItem {
                    navigationItem.rightBarButtonItems = [buttonItem]
                }
            }
        }
    }
    
    //  weak var delegate: MediaViewControllerDelegate?
    
}

extension MediaCollectionViewController: UISearchControllerDelegate {
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        searchController.delegate = self
        title = "Music.ly"
        buttonItem = UIBarButtonItem(image: dataSource.image, style: .plain, target: self, action: #selector(navigationBarSetup))
        navigationItem.setRightBarButton(buttonItem, animated: false)
        setupSearchController()
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let searchBarText = searchBar.text, searchBarText.characters.count > 0 { searchBarActive = true }
    }
    
    func setupSearchController() {
        setSearchBarColor(searchBar: searchBar)
        searchController.dimsBackgroundDuringPresentation = false
        searchController.definesPresentationContext = true
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        definesPresentationContext = true
        searchBar.barTintColor = .white
    }
    
    func navigationBarSetup() {
        guard let navController = self.navigationController else { return }
        setupNavigationBar(navController: navController, searchController: searchController)
        searchBar.becomeFirstResponder()
    }
    
    func setupNavigationBar(navController: UINavigationController, searchController: UISearchController) {
        navController.navigationBar.barTintColor = NavigationBarAttributes.navBarTint
        searchController.hidesNavigationBarDuringPresentation = false
        searchBar = searchController.searchBar
        navigationItem.titleView = searchBar
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = .white
        navigationItem.rightBarButtonItem?.tintColor = .white
    }
}

extension MediaCollectionViewController: UISearchBarDelegate {
    
    public func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        dataSource.playlist?.removeAll()
        searchBar.setShowsCancelButton(true, animated: true)
        searchBarActive = true
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func setSearchBarActive() {
        self.searchBarActive = true
    }
    
    public func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: false)
        searchBarActive = false
    }
    
    func searchBarHasInput() {
        collectionView.reloadData()
        dataSource.playlist?.removeAll()
        dataSource.store.searchForTracks { [weak self] playlist, error in
            guard let playlist = playlist, let strongSelf = self else { return }
            strongSelf.dataSource.playlist = playlist
            strongSelf.collectionView.reloadData()
            strongSelf.collectionView.performBatchUpdates ({
                DispatchQueue.main.async {
                    // strongSelf.contentState = .results
                    strongSelf.collectionView.reloadItems(at: strongSelf.collectionView.indexPathsForVisibleItems)
                    strongSelf.collectionView.isHidden = false
                }
            }, completion: { finished in
                print(finished)
            })
        }
    }
    
    func searchOnTextChange(text: String, store: MediaDataStore, navController: UINavigationController) {
        dataSource.store.setSearch(string: text)
        searchBarActive = true
        if text != "" { searchBarHasInput() }
        navController.navigationBar.topItem?.title = "Search: \(text)"
        UIView.animate(withDuration: 1.8) {
            self.collectionView.alpha = 1
        }
    }
    
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("searchBarSearchButtonClicked")
        DispatchQueue.main.async {
            self.navigationItem.rightBarButtonItems = []
        }
        if !searchBarActive {
            collectionView.reloadData()
        }
        searchController.searchBar.resignFirstResponder()
    }
    
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let barText = searchBar.text, let navcontroller = self.navigationController else { return }
        searchOnTextChange(text: barText, store: dataSource.store, navController: navcontroller)
    }
    
    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        dataSource.playlist?.removeAll()
        //contentState = .none
        collectionView.reloadData()
        navigationItem.setRightBarButton(buttonItem, animated: false)
        searchBarActive = false
    }
    
}

extension MediaCollectionViewController: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchString = searchController.searchBar.text
        if searchString != nil {
            dataSource.playlist?.removeAll()
            if let searchString = searchString {
                self.dataSource.store.setSearch(string: searchString)
                self.dataSource.store.searchForTracks { [weak self] tracks, error in
                    guard let strongSelf = self, let tracks = tracks else { return }
                    strongSelf.dataSource.playlist = tracks
                }
            }
        }
        collectionView.reloadData()
    }
    
    public func updateSearchResults(for searchController: UISearchController) {
        searchBarActive = true
    }
}
