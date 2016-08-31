//
//  SearchCell.swift
//  RealMusic
//
//  Created by asiantech on 8/29/16.
//  Copyright © 2016 asiantech. All rights reserved.
//

import UIKit
import AlamofireImage

class SearchCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageSong: UIImageView!
    @IBOutlet weak var artistLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageSong.layer.cornerRadius = imageSong.frame.size.width/2.0
        imageSong.layer.masksToBounds = true
        imageSong.layer.borderWidth = 1.0
        imageSong.layer.borderColor = UIColor.orangeColor().CGColor
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(object: Song) {
        if object.kind == "track" {
            self.nameLabel.text = object.title
            self.artistLabel.text = object.user?.username
            var imageThumb = ""
            if object.artwork_url != "" {
                imageThumb = object.artwork_url
            } else {
                imageThumb = object.user.avatar_url
            }
            let thumb = NSURL(string: imageThumb)!
            let request = NSURLRequest(URL: thumb)
            self.imageSong.af_setImageWithURLRequest(request, placeholderImage: UIImage(named: "img_holder"), filter: nil, progress: nil, progressQueue: dispatch_get_main_queue(), imageTransition: UIImageView.ImageTransition.CrossDissolve(0.5), runImageTransitionIfCached: true) { (response) in
                switch response.result {
                case .Success(let value):
                    print("success: \(value)")
                case .Failure(let error):
                    print(error.localizedDescription)
                }
            }
        } else {
            if object.username == "" && object.title != "" {
                self.nameLabel.text = object.title
            } else {
                self.nameLabel.text = object.username
            }
            
            if object.city != "" && object.country != "" {
                self.artistLabel.text = object.city + "/" + object.country
            } else if object.city == "" || object.country == "" {
                if object.myspace_name == "" && object.user?.username != ""{
                    self.artistLabel.text = object.user?.username
                } else {
                    self.artistLabel.text = object.myspace_name
                }
            } else if object.city != "" && object.country == "" {
                self.artistLabel.text = object.city
            } else {
                self.artistLabel.text = object.country
            }
            let thumb = NSURL(string: object.avatar_url)!
            let request = NSURLRequest(URL: thumb)
            self.imageSong.af_setImageWithURLRequest(request, placeholderImage: UIImage(named: "img_holder"), filter: nil, progress: nil, progressQueue: dispatch_get_main_queue(), imageTransition: UIImageView.ImageTransition.CrossDissolve(0.5), runImageTransitionIfCached: true) { (response) in
                switch response.result {
                case .Success(let value):
                    print("success: \(value)")
                case .Failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        }
        
    }
    
}
