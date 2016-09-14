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
    private var isLoadMore = true
    private var isSearch = false
    private var indexSearch = 0
    private var searchName = ""
    private var isLoad = false
    
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
        isLoad = true
        self.service.getURLSearchName(searchName, limit: limit, offset: offset) { (success, result, error) in
            self.hideLoading()
            self.isLoad = false
            if success {
                if let result = result as? [[String: AnyObject]] {
                    
//                    if !self.isLoadMore {
//                        self.songs.removeAll()
//                    }
                    if self.isSearch {
                        self.songs.removeAll()
                        self.isSearch = false
                    }
//                    self.songs.removeAll(
                    self.isLoadMore = result.count > 0
                    for dictionary in result {
                        let song = Mapper<Song>().map(dictionary)
                        var noAdd = false
                        for obj in self.songs {
                            if obj.id == song?.id {
                                noAdd = true
                            }
                        }
                        if !noAdd {
                            self.songs.append(song!)
                        }
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
        print(songs.count)
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let songOB = songs[indexPath.row]
        if songOB.kind == "track" {
            if songOB.streamable == true {
                let detailVC = DetailViewController.initialization()
                detailVC.songs = songOB
                navigationController?.pushViewController(detailVC, animated: true)
            } else {
                let userWebVC = UserViewController.initialization()
                userWebVC.userUrlString = songOB.permalink_url
                navigationController?.pushViewController(userWebVC, animated: true)
            }
        } else {
            if songOB.permalink_url == "" {
                print("khong co url")
            } else {
                let userWebVC = UserViewController.initialization()
                userWebVC.userUrlString = songOB.permalink_url
                navigationController?.pushViewController(userWebVC, animated: true)
            }
        }
       
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.layer.transform = CATransform3DMakeScale(0.1,0.1,1)
        UIView.animateWithDuration(0.35, animations: {
            cell.layer.transform = CATransform3DMakeScale(1,1,1)
        })
        let lastElement = songs.count - 1
        if indexPath.row == lastElement && isLoadMore {
            self.getJson(searchName, limit: 20, offset: songs.count)
        }
    }
}



extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        isSearch = false
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text!.isEmpty {
            isSearch = false
            songs.removeAll()
            tableView.reloadData()
        } else {
            isSearch = true
            let whiteSpace = NSCharacterSet.whitespaceCharacterSet()
            let searchText = searchBar.text
            let range = searchText?.rangeOfCharacterFromSet(whiteSpace)
            if let _ = range {
                searchName = searchText!
                indexSearch += 1
                let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(2 * Double(NSEC_PER_SEC)))
                dispatch_after(delayTime, dispatch_get_main_queue()) {
                    if !self.isLoad {
                        self.getJson( self.searchName, limit: 20, offset: 0)
                    }
                }
                
            } else {
                indexSearch += 1
                let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(2 * Double(NSEC_PER_SEC)))
                dispatch_after(delayTime, dispatch_get_main_queue()) {
                    if !self.isLoad {
                        self.isLoadMore = false
                        self.getJson(searchBar.text!, limit: 20, offset: 0)
                    }
                }
               
            }
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        searchBar.resignFirstResponder()
    }
}
