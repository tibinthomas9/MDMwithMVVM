//
//  Device.swift
//  MDMwithMVVM
//
//  Created by Tibin Thomas on 24/04/22.
//

import Foundation

struct Devices: Codable {
    var devices: [Device]
}


// MARK: - Device
struct Device: Codable {
    let id, type: String
    let price: Int
    let currency: String
    let isFavorite: Bool
    let imageURL, title, deviceDescription: String

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case type = "Type"
        case price = "Price"
        case currency = "Currency"
        case isFavorite
        case imageURL = "imageUrl"
        case title = "Title"
        case deviceDescription = "Description"
    }
}

// MARK: Device convenience initializers and mutators

extension Device {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Device.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        id: String? = nil,
        type: String? = nil,
        price: Int? = nil,
        currency: String? = nil,
        isFavorite: Bool? = nil,
        imageURL: String? = nil,
        title: String? = nil,
        deviceDescription: String? = nil
    ) -> Device {
        return Device(
            id: id ?? self.id,
            type: type ?? self.type,
            price: price ?? self.price,
            currency: currency ?? self.currency,
            isFavorite: isFavorite ?? self.isFavorite,
            imageURL: imageURL ?? self.imageURL,
            title: title ?? self.title,
            deviceDescription: deviceDescription ?? self.deviceDescription
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}

// MARK: - URLSession response handlers

extension URLSession {
    fileprivate func codableTask<T: Codable>(with url: URL, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                return
            }
            completionHandler(try? newJSONDecoder().decode(T.self, from: data), response, nil)
        }
    }

    func deviceTask(with url: URL, completionHandler: @escaping (Device?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
}

