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
    @IBOutlet private weak var shareButton: UIButton!
    
    var viewModel: DetailsViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    private func configureView() {
        shareButton.layer.cornerRadius = 8
        shareButton.setTitle("SHARE", for: .normal)
        
        guard let comics = viewModel?.comics else { return }
        
        titleLabel.text = comics.title
        descriptionLabel.text = comics.description
        
        if let imageUrl = comics.image {
            imageView.loadImageWithUrl(urlString: imageUrl)
        }
    }
    
    private func share(comics: Comics) {
        guard let image = imageView.image else { return }
        
        let activityVC = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = view

        present(activityVC, animated: true, completion: nil)
    }
    
    @IBAction private func shareButtonAction(_ sender: Any) {
        guard let comics = viewModel?.comics else { return }
        share(comics: comics)
    }
}
