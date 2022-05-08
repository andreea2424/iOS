//
//  SearchPoemTableView.swift
//  book
//
//  Created by Andreea Stanciu on 08/05/2022.
//  Copyright © 2022 andr. All rights reserved.
//

import Foundation
import UIKit


final class SearchPoemTableView: UITableViewCell{
    static let cellid = "SearchPoemTableView"
    
    private let titleLabel = UILabel()
    private let ratingLabel = UILabel()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
   
    
    
    private func configure(){
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(ratingLabel)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10 ).isActive = true
        stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10 ).isActive = true
        stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10 ).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10 ).isActive = true
    }
    
    func setUp(RatingEntity: RatingEntity){
        
        
        titleLabel.text = RatingEntity.name
        ratingLabel.text = String(RatingEntity.rating)
    }
    override var reuseIdentifier: String? {
        return SearchPoemTableView.cellid
        
    }
    
     required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
    
    
}
