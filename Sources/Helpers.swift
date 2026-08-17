//
// Created by Kojiro Futamura on 2018-11-19.
//

import Foundation

/// Returns the last index of the specified element in the substring.
///
/// - Parameter element: The character to search for.
/// - Returns: The index of the last occurrence of the character, or nil if the character is not found.
extension Substring {
    internal func lastIndex(of element: Character) -> String.Index? {
        var position: Index = endIndex
        while position > startIndex {
            position = self.index(before: position)
            if self[position] == element {
                return position
            }
        }
        return nil
    }
}

/// A computed property that checks if the Unicode scalar is acceptable in
/// punycode-encoded text.
///
/// - Returns: A boolean value indicating whether the Unicode scalar is valid.
///   C1 control characters (U+0080...U+009F) never appear in legitimate
///   punycode input or output; surrogates and out-of-range values are already
///   unrepresentable in `Unicode.Scalar`.
extension UnicodeScalar {
    internal var isValid: Bool {
        return !(0x80...0x9F).contains(value)
    }
}
