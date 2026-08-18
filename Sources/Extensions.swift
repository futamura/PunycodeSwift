//
// Created by Kojiro Futamura on 2018-11-19.
//

import Foundation

/// This extension provides methods for encoding and decoding strings using Punycode (RFC 3492)
/// and IDNA encoding. It allows for the conversion of Substring instances to their Punycode
/// and IDNA representations, facilitating the handling of internationalized domain names.
public extension Substring {
    /// Returns new string in punycode encoding (RFC 3492)
    ///
    /// This is the raw RFC 3492 transformation of a single label: no `xn--`
    /// prefix is added and dots are not treated as label separators, so
    /// all-ASCII input yields a trailing delimiter (e.g. `"goo.gl"` becomes
    /// `"goo.gl-"`). Use ``idnaEncoded`` to encode a hostname.
    ///
    /// - Returns: Punycode encoded string or nil if the string can't be encoded
    var punycodeEncoded: String? {
        return Puny().encodePunycode(self)
    }

    /// Returns new string decoded from punycode representation (RFC 3492)
    ///
    /// - Returns: Original string or nil if the string doesn't contain correct encoding
    var punycodeDecoded: String? {
        return Puny().decodePunycode(self)
    }

    /// Returns new string containing IDNA-encoded hostname
    ///
    /// The hostname is mapped before encoding (NFKC compatibility folding,
    /// lowercasing, NFC) and split on label separators, and only labels that
    /// need it get the `xn--` ACE prefix.
    ///
    /// - Returns: IDNA encoded hostname or nil if the string can't be encoded
    var idnaEncoded: String? {
        return Puny().encodeIDNA(self)
    }

    /// Returns new string containing hostname decoded from IDNA representation
    ///
    /// - Returns: Original hostname or nil if the string doesn't contain correct encoding
    var idnaDecoded: String? {
        return Puny().decodedIDNA(self)
    }

    /// Returns new string with the host portion of a URL IDNA-encoded
    ///
    /// Unlike ``idnaEncoded``, which treats the whole string as a hostname,
    /// this accepts a URL-shaped string and encodes only its host: scheme,
    /// userinfo, port, path, query, and fragment are preserved unchanged.
    ///
    /// - Returns: The URL with its host IDNA-encoded, or nil if the host can't be encoded
    var idnaEncodedURL: String? {
        return Puny().encodeIDNAURL(self)
    }

    /// Returns new string with the host portion of a URL decoded from IDNA representation
    ///
    /// Unlike ``idnaDecoded``, which treats the whole string as a hostname,
    /// this accepts a URL-shaped string and decodes only its host: scheme,
    /// userinfo, port, path, query, and fragment are preserved unchanged.
    ///
    /// - Returns: The URL with its host decoded, or nil if the host doesn't contain correct encoding
    var idnaDecodedURL: String? {
        return Puny().decodedIDNAURL(self)
    }
}

/// This extension provides methods for encoding and decoding strings using Punycode (RFC 3492)
/// and IDNA encoding. It allows for the conversion of String instances to their Punycode
/// and IDNA representations, facilitating the handling of internationalized domain names.
public extension String {

    /// Returns new string in punycode encoding (RFC 3492)
    ///
    /// This is the raw RFC 3492 transformation of a single label: no `xn--`
    /// prefix is added and dots are not treated as label separators, so
    /// all-ASCII input yields a trailing delimiter (e.g. `"goo.gl"` becomes
    /// `"goo.gl-"`). Use ``idnaEncoded`` to encode a hostname.
    ///
    /// - Returns: Punycode encoded string or nil if the string can't be encoded
    var punycodeEncoded: String? {
        return self[..<self.endIndex].punycodeEncoded
    }

    /// Returns new string decoded from punycode representation (RFC 3492)
    ///
    /// - Returns: Original string or nil if the string doesn't contain correct encoding
    var punycodeDecoded: String? {
        return self[..<self.endIndex].punycodeDecoded
    }

    /// Returns new string containing IDNA-encoded hostname
    ///
    /// The hostname is mapped before encoding (NFKC compatibility folding,
    /// lowercasing, NFC) and split on label separators, and only labels that
    /// need it get the `xn--` ACE prefix.
    ///
    /// - Returns: IDNA encoded hostname or nil if the string can't be encoded
    var idnaEncoded: String? {
        return self[..<self.endIndex].idnaEncoded
    }

    /// Returns new string containing hostname decoded from IDNA representation
    ///
    /// - Returns: Original hostname or nil if the string doesn't contain correct encoding
    var idnaDecoded: String? {
        return self[..<self.endIndex].idnaDecoded
    }

    /// Returns new string with the host portion of a URL IDNA-encoded
    ///
    /// Unlike ``idnaEncoded``, which treats the whole string as a hostname,
    /// this accepts a URL-shaped string and encodes only its host: scheme,
    /// userinfo, port, path, query, and fragment are preserved unchanged.
    ///
    /// - Returns: The URL with its host IDNA-encoded, or nil if the host can't be encoded
    var idnaEncodedURL: String? {
        return self[..<self.endIndex].idnaEncodedURL
    }

    /// Returns new string with the host portion of a URL decoded from IDNA representation
    ///
    /// Unlike ``idnaDecoded``, which treats the whole string as a hostname,
    /// this accepts a URL-shaped string and decodes only its host: scheme,
    /// userinfo, port, path, query, and fragment are preserved unchanged.
    ///
    /// - Returns: The URL with its host decoded, or nil if the host doesn't contain correct encoding
    var idnaDecodedURL: String? {
        return self[..<self.endIndex].idnaDecodedURL
    }
}
