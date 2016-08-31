//
//  SearchViewController.swift
//  RealMusic
//
//  Created by asiantech on 8/25/16.
//  Copyright © 2016 asiantech. All rights reserved.
//

import UIKit
import ObjectMapper

class SearchViewController: RMViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    private var service = WebService()
    private var songs = [Song]()
    private var isLoadMore = false
    private var isSearch = false
    private var indexSearch = 0
    private var searchName = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func setupUI() {
        super.setupUI()
        tableView.registerNib(UINib(nibName: "SearchCell", bundle: nil), forCellReuseIdentifier: "SearchCell")
    }
    
    override func setupData() {
        super.setupData()
//        getJson(searchName, limit: 20, offset: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    private func getJson(searchName:String, limit: Int, offset: Int) {
        showLoading()
        self.service.getURLSerchName(searchName, limit: limit, offset: offset) { (success, result, error) in
            self.hideLoading()
            if success {
                if let result = result as? [[String: AnyObject]] {
                    
                    if !self.isLoadMore {
                        self.songs.removeAll()
                    }
                    for dictionary in result {
                        let song = Mapper<Song>().map(dictionary)
                        self.songs.append(song!)
                        self.tableView.reloadData()
                    }
                } else {
                    self.isLoadMore = false
                }
            }
        }
    }

}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SearchCell") as! SearchCell
        cell.configCell(songs[indexPath.row])
        return cell
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        let lastElement = songs.count - 1
        if indexPath.row == lastElement && isLoadMore {
            self.getJson(searchName, limit: 20, offset: 20)
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text!.isEmpty {
            isSearch = false
            tableView.reloadData()
        } else {
            isSearch = true
            let whiteSpace = NSCharacterSet.whitespaceCharacterSet()
            let searchText = searchBar.text
            let range = searchText?.rangeOfCharacterFromSet(whiteSpace)
            if let _ = range {
                let searchText = searchText
                indexSearch += 1
                print(searchText)
                getJson(searchText!, limit: 20, offset: 0)
            } else {
                indexSearch += 1
                print(searchBar.text)
                getJson(searchBar.text!, limit: 20, offset: 0)
            }
        }
    }
}
