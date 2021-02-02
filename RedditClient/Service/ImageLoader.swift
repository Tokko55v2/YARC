//
//  ImageLoader.swift
//  RedditClient
//
//  Created by Michael Kroneder on 01/02/2021.
//

import Alamofire
import UIKit

class ImageLoader: ObservableObject {
    var imageCache = ImageCache.getImageCache()
    @Published var image: UIImage?

    init(urlString: String) {
        if loadFromCache(urlString: urlString) {
            return
        }

        loadFromURL(urlString: urlString)
    }

    func loadFromCache(urlString: String) -> Bool {
        guard URL(string: urlString) != nil else {
            return false
        }

        guard let image = imageCache.get(forKey: urlString) else {
            return false
        }

        self.image = image
        return true
    }

    func loadFromURL(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let task = AF.request(url)
            .validate()
            .responseData { respone in
                switch respone.result {
                case let .failure(error):
                    print(error)
                case let .success(data):
                    DispatchQueue.main.async {
                        guard let image = UIImage(data: data) else {
                            return
                        }
                        self.image = image
                        self.imageCache.set(forKey: urlString, image: image)
                    }
                }
            }
        task.resume()
    }
}

class ImageCache {
    var cache = NSCache<NSString, UIImage>()

    func get(forKey: String) -> UIImage? {
        cache.object(forKey: NSString(string: forKey))
    }

    func set(forKey: String, image: UIImage) {
        cache.setObject(image, forKey: NSString(string: forKey))
    }
}

extension ImageCache {
    static var imageCache = ImageCache()
    static func getImageCache() -> ImageCache {
        imageCache
    }
}
