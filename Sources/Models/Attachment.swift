//
// DirectLine
//
// Copyright © 2018 Guille Gonzalez. All rights reserved.
// See LICENSE file for license.
//

import Foundation

public protocol Attachable: Decodable {
	static var contentType: String { get }
}

/// Defines additional information to include in the message.
///
/// An attachment may be a media file (e.g., audio, video, image, file) or a rich card.
public struct Attachment: Codable {
	public enum Content {
		case media(URL)
		case card(Any)
		case unknown
	}

	/// The media type of the content in the attachment.
	public let contentType: String

	/// The content of the attachment.
	public let content: Content

	/// Name of the attachment.
	public let name: String?

	/// An optional thumbnail image.
	public let thumbnailURL: URL?

	// MARK: - Initialization

	public init(contentType: String, url: URL, name: String? = nil, thumbnailURL: URL? = nil) {
		self.contentType = contentType
		content = .media(url)
		self.name = name
		self.thumbnailURL = thumbnailURL
	}

	// MARK: - Codable

	private enum CodingKeys: String, CodingKey {
		case contentType, content, name
		case contentURL = "contentUrl"
		case thumbnailURL = "thumbnailUrl"
	}

	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		contentType = try container.decode(String.self, forKey: .contentType)

		if let url = try container.decodeIfPresent(URL.self, forKey: .contentURL) {
			content = .media(url)
		} else if let decodeContent = Attachment.decoders[contentType] {
			content = try .card(decodeContent(container))
		} else {
			content = .unknown
		}

		name = try container.decodeIfPresent(String.self, forKey: .name)
		thumbnailURL = try container.decodeIfPresent(URL.self, forKey: .thumbnailURL)
	}

	public func encode(to encoder: Encoder) throws {
		guard case let .media(url) = content else {
			let context = EncodingError.Context(codingPath: [], debugDescription: "Unsupported attachment content.")
			throw EncodingError.invalidValue(content, context)
		}

		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encode(contentType, forKey: .contentType)
		try container.encode(url, forKey: .contentURL)
		try container.encodeIfPresent(name, forKey: .name)
		try container.encodeIfPresent(thumbnailURL, forKey: .thumbnailURL)
	}

	// MARK: - Registration

	private typealias AttachmentDecoder = (KeyedDecodingContainer<CodingKeys>) throws -> Any
	private static var decoders: [String: AttachmentDecoder] = [:]

	public static func register<A: Attachable>(_ type: A.Type) {
		decoders[A.contentType] = { container in
			try container.decode(A.self, forKey: .content)
		}
	}
}
