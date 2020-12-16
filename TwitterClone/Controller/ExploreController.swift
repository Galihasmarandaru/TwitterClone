//
//  ExploreController.swift
//  TwitterClone
//
//  Created by Galih Asmarandaru on 15/10/20.
//

import UIKit

class ExploreController: UIViewController {
    // MARK: - Properties
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: - Helper
    func configureUI() {
        view.backgroundColor = .white
        navigationItem.title = "Explore"
    }
}
