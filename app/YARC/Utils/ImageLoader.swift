//
//  ImageLoader.swift
//  YARC
//
//  Created by Michael Kroneder on 18/04/2021.
//

import Combine
import Foundation
import SwiftUI
import YARC_SDK

class ImageLoader: ObservableObject {
    private var repository = Repository()
    private var cancellable = Set<AnyCancellable>()
    private var cachedImage = ImageCache()
    private var url: String

    @Published var image: UIImage?

    init(url: String) {
        self.url = url
    }

    func load() {
        guard URL(string: url) != nil else {
            return
        }

        guard loadFromCache(urlString: url) == nil else {
            image = UIImage(data: loadFromCache(urlString: url)!)
            return
        }

        repository.getImage(imgaeRequest: ImageRequest(url: url))
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case let .failure(error):
                    print(error)
                case .finished:
                    break
                }
            }, receiveValue: { response in
                self.cachedImage.set(forKey: self.url, image: response.image)
                self.image = UIImage(data: response.image)
            })
            .store(in: &cancellable)
    }

    private func loadFromCache(urlString: String) -> Data? {
        guard let image = cachedImage.get(forKey: urlString) else {
            return nil
        }
        return image
    }
}

private struct ImageCache {
    var cache = NSCache<NSString, NSData>()

    func get(forKey: String) -> Data? {
        cache.object(forKey: NSString(string: forKey)) as Data?
    }

    func set(forKey: String, image: Data) {
        cache.setObject(image as NSData, forKey: NSString(string: forKey))
    }
}
