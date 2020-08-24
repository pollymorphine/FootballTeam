//
//  SearchContentView.swift
//  FootballTeam
//
//  Created by Polina on 23.08.2020.
//  Copyright © 2020 SergeevaPolina. All rights reserved.
//

import UIKit

class SearchContainerView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    private func setUpView () {
        layer.cornerRadius = 10.0
        clipsToBounds = true
    }

}
