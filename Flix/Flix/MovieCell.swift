//
//  MovieCell.swift
//  Flix
//
//  Created by Omar Valenzuela on 8/9/18.
//  Copyright © 2018 Omar Valenzuela. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    
    var movie : Movie!
    
    func setupViews(){
        posterImage.af_setImage(withURL: movie.posterURL!)
        titleLabel.text = movie.title
        overviewLabel.text = movie.overview
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
