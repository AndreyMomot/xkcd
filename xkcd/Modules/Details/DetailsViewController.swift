//
//  DetailsViewController.swift
//  xkcd
//
//  Created by Andrii Momot on 01.05.2022.
//

import UIKit

final class DetailsViewController: BaseViewController {
        
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var imageView: LoadableImageView!
    
    var viewModel: DetailsViewModelProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    private func configureView() {
        guard let comics = viewModel?.comics else { return }
        
        titleLabel.text = comics.title
        descriptionLabel.text = comics.description
        
        if let imageUrl = comics.image {
            imageView.loadImageWithUrl(urlString: imageUrl)
        }
    }
    
}
