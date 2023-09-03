//
//  EpisodeCollectionViewCell.swift
//  RM Client
//
//  Created by Yazan Tarifi on 03/09/2023.
//

import UIKit

class EpisodeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var episodeView: UILabel!
    @IBOutlet weak var shownAtView: UILabel!
    @IBOutlet weak var episodeNameView: UILabel!
    
    public func configure(item: RmEpisodeModel?) {
        episodeView?.text = item?.episode ?? ""
        shownAtView?.text = item?.air_date ?? ""
        episodeNameView?.text = item?.name ?? ""
    }

}
