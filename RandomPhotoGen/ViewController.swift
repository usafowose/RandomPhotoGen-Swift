//
//  ViewController.swift
//  RandomPhotoGen
//
//  Created by Andrew Fowose on 5/28/23.
//

import UIKit

class ViewController: UIViewController {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView();
        imageView.contentMode = .scaleAspectFill;
        imageView.backgroundColor = .white;
        
        return imageView;
    }()
    
    private let button: UIButton = {
        let button = UIButton();
        button.backgroundColor = .white
        button.setTitle("Random Photo", for: .normal)
        button.setTitleColor(.black, for: .normal)
        
        return button;
    }()
    
    let colors: [UIColor] = [
        .systemRed,
        .systemBlue,
        .systemCyan,
        .systemOrange,
        .systemYellow,
        .systemBrown,
        .systemMint,
        .systemGreen,
        .systemIndigo
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = colors.randomElement();
        view.addSubview(imageView);
        view.addSubview(button);
        
        imageView.frame = CGRect(x: 0, y: 0, width: 300, height: 300);
        imageView.center = view.center;
        
        getRandomPhoto();
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    @objc func didTapButton() {
        getRandomPhoto()
        view.backgroundColor = colors.randomElement()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        button.frame = CGRect(x: 30, y: view.frame.size.height-150-view.safeAreaInsets.bottom, width: view.frame.size.width-55, height: 60)
    };

    func getRandomPhoto() {
        let urlString = "https://source.unsplash.com/collection/3178572,357786/600x600"
        guard let url = URL(string: urlString) else {
            return
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: url) { [weak self] (data, response, error) in
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            if let data = data {
                DispatchQueue.main.async { [weak self] in
                    self?.imageView.image = UIImage(data: data)
                }
            }
        }
        task.resume()
    }

}

