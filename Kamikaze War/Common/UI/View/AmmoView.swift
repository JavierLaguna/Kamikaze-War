//
//  AmmoView.swift
//  Kamikaze War
//
//  Created by Javier Laguna on 09/06/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import UIKit

class AmmoView: UIView {
    
    // MARK: IBOutlets
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var label: UILabel!
    
    // MARK: Constants
    let viewModel: AmmoViewModel
    
    // MARK: LifeCycle
    init(viewModel: AmmoViewModel) {
        self.viewModel = viewModel
        
        super.init(frame: .zero)
        
        commonInit()
        loadViewModelData()
        
        viewModel.viewDelegate = self
        viewModel.viewWasLoaded()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func commonInit() {
        let bundle = Bundle.init(for: AmmoView.self)
        if let bundleViews = bundle.loadNibNamed("AmmoView", owner: self, options: nil),
            let contentView = bundleViews.first as? UIView {
            
            contentView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(contentView)
            NSLayoutConstraint.activate([
                contentView.topAnchor.constraint(equalTo: topAnchor),
                contentView.leftAnchor.constraint(equalTo: leftAnchor),
                contentView.rightAnchor.constraint(equalTo: rightAnchor),
                contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        }
    }
    
    private func loadViewModelData() {
        label.text = viewModel.countText
        imageView.image = viewModel.icon
        layer.borderColor = viewModel.color.cgColor
        
        changeSelection()
    }
    
    private func changeSelection() {
        layer.borderWidth = viewModel.isSelected ? 1 : 0
    }
}

// MARK: AmmoViewDelegate
extension AmmoView: AmmoViewDelegate {
    
    func bulletUpdated() {
        label.text = viewModel.countText
        changeSelection()
        
        setNeedsLayout()
        layoutIfNeeded()
    }
}
