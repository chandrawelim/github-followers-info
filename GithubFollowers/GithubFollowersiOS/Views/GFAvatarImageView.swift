//
//  GFAvatarImageView.swift
//  GithubFollowersiOS
//
//  Created by Chandra Welim on 15/06/25.
//

import UIKit

class GFAvatarImageView: UIImageView {
    
    let placeholderImage = Images.placeholder
    let cache = NSCache<NSString, UIImage>()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        _configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func _configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func downloadImage(fromURL url: String) {
        let cacheKey = NSString(string: url)
        
        if let cachedImage = cache.object(forKey: cacheKey) {
            self.image = cachedImage
            return
        }
        
        guard let imageURL = URL(string: url) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: imageURL) { [weak self] data, response, error in
            guard let self = self,
                  error == nil,
                  let response = response as? HTTPURLResponse, response.statusCode == 200,
                  let data = data,
                  let image = UIImage(data: data) else {
                return
            }
            
            self.cache.setObject(image, forKey: cacheKey)
            
            DispatchQueue.main.async {
                self.image = image
            }
        }
        
        task.resume()
    }
}


