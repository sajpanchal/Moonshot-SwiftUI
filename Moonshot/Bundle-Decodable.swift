//
//  Bundle-Decodable.swift
//  Moonshot
//
//  Created by saj panchal on 2021-06-23.
//

import Foundation

extension Bundle {
    // method that takes file name and returns decoded data in form of array of Astronaut Struct.
    func decode<T: Codable>(_ file: String) -> T {
        // get the url of the file from resource name from bundle.
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        // get the data of Data type from a given url.
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }
        // create a json decoder.
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        // decode the data into an array of Astronaut struct.
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }
        return loaded
    }
}
