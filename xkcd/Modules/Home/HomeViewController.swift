//
//  HomeViewController.swift
//  xkcd
//
//  Created by Andrii Momot on 01.05.2022.
//

import UIKit

final class HomeViewController: BaseViewController {
    
    @IBOutlet private weak var previousButton: UIButton!
    @IBOutlet private weak var randomButton: UIButton!
    @IBOutlet private weak var nextButton: UIButton!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var imageView: LoadableImageView!
    @IBOutlet private weak var storeButton: UIButton!
    
    var viewModel: HomeViewModelProtocol?
    var onShowDetails: ((Comics) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        binding()
        viewModel?.getStoredComics()
        viewModel?.search(for: .random)
    }
    
    private func setupView() {
        previousButton.layer.cornerRadius = 8
        randomButton.layer.cornerRadius = 8
        nextButton.layer.cornerRadius = 8
        
        previousButton.setTitle("Previous", for: .normal)
        randomButton.setTitle("Random", for: .normal)
        nextButton.setTitle("Next", for: .normal)
        
        storeButton.setTitle("", for: .normal)
        storeButton.tintColor = .red
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    private func binding() {
        viewModel?.comics.bind {[weak self] comics  in
            DispatchQueue.main.async {
                self?.configureView(with: comics)
            }
        }
        
        viewModel?.error.bind {[weak self] error  in
            DispatchQueue.main.async {
                self?.showAlert(withTitle: "Error", message: error?.localizedDescription, closeHandler: nil)
            }
        }
    }
    
    private func configureView(with comics: Comics?) {
        guard let comics = comics else { return  }
        
        title = "\(comics.id)"
        
        titleLabel.text = comics.title
        
        if let imageUrl = comics.image {
            imageView.loadImageWithUrl(urlString: imageUrl)
        }
        
        let storedImage = UIImage(named: "like")?.withRenderingMode(.alwaysTemplate)
        let unstoredImage = UIImage(named: "unlike")?.withRenderingMode(.alwaysTemplate)
        let image = comics.isStored ? unstoredImage : storedImage
        storeButton.setImage(image, for: .normal)
    }

    @objc private func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        guard let _ = tapGestureRecognizer.view as? UIImageView,
        let comics = viewModel?.comics.value else {
            return
        }
        onShowDetails?(comics)
    }
    
    @IBAction private func previousButtonAction(_ sender: Any) {
        viewModel?.search(for: .previous)
    }
    
    @IBAction private func randomButtonAction(_ sender: Any) {
        viewModel?.search(for: .random)
    }
    
    @IBAction private func nextButtonAction(_ sender: Any) {
        viewModel?.search(for: .next)
    }
    
    @IBAction private func storeButtonAction(_ sender: Any) {
        viewModel?.storeComics()
    }
}
