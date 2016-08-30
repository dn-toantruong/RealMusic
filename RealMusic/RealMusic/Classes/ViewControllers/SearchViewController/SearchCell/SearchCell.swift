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
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(object: Song) {
        self.nameLabel.text = object.title
        self.artistLabel.text = object.user.username
        let thumb = NSURL(string: object.artwork_url)!
        let request = NSURLRequest(URL: thumb)
        self.imageSong.af_setImageWithURLRequest(request, placeholderImage: nil, filter: nil, progress: nil, progressQueue: dispatch_get_main_queue(), imageTransition: UIImageView.ImageTransition.CrossDissolve(0.5), runImageTransitionIfCached: true) { (response) in
            switch response.result {
            case .Success(let value):
                print("success: \(value)")
            case .Failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
