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
    @Published var image: Data?

    init(urlString: String) {
        if loadFromCache(urlString: urlString) {
            return
        }

        loadFromURL(urlString: urlString)
    }

    private func loadFromCache(urlString: String) -> Bool {
        guard URL(string: urlString) != nil else {
            return false
        }

        guard let image = imageCache.get(forKey: urlString) else {
            return false
        }

        self.image = image
        return true
    }

    private func loadFromURL(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let task = AF.request(url)
            .validate()
            .responseData { respone in
                switch respone.result {
                case let .failure(error):
                    print(error)
                case let .success(data):
                    DispatchQueue.main.async {
                        self.image = data
                        self.imageCache.set(forKey: urlString, image: data)
                    }
                }
            }
        task.resume()
    }
}

class ImageCache {
    var cache = NSCache<NSString, NSData>()

    func get(forKey: String) -> Data? {
        cache.object(forKey: NSString(string: forKey)) as Data?
    }

    func set(forKey: String, image: Data) {
        cache.setObject(image as NSData, forKey: NSString(string: forKey))
    }
}

extension ImageCache {
    static var imageCache = ImageCache()
    static func getImageCache() -> ImageCache {
        imageCache
    }
}
