//
//  PunycodeTests.swift
//  PunycodeTests
//
//  Created by Kojiro Futamura on 2024/08/25.
//

import XCTest

@testable import Punycode

final class PunycodeTests: XCTestCase {

    let egyptian: String = "\u{0644}\u{064A}\u{0647}\u{0645}\u{0627}\u{0628}\u{062A}\u{0643}\u{0644}\u{0645}\u{0648}\u{0634}\u{0639}\u{0631}\u{0628}\u{064A}\u{061F}"
    let chineseSimplified: String = "\u{4ED6}\u{4EEC}\u{4E3A}\u{4EC0}\u{4E48}\u{4E0D}\u{8BF4}\u{4E2D}\u{6587}"
    let chineseTraditional: String = "\u{4ED6}\u{5011}\u{7232}\u{4EC0}\u{9EBD}\u{4E0D}\u{8AAA}\u{4E2D}\u{6587}"
    let czech: String =
        "\u{0050}\u{0072}\u{006F}\u{010D}\u{0070}\u{0072}\u{006F}\u{0073}\u{0074}\u{011B}\u{006E}\u{0065}\u{006D}\u{006C}\u{0075}\u{0076}\u{00ED}\u{010D}\u{0065}\u{0073}\u{006B}\u{0079}"
    let hebrew: String =
        "\u{05DC}\u{05DE}\u{05D4}\u{05D4}\u{05DD}\u{05E4}\u{05E9}\u{05D5}\u{05D8}\u{05DC}\u{05D0}\u{05DE}\u{05D3}\u{05D1}\u{05E8}\u{05D9}\u{05DD}\u{05E2}\u{05D1}\u{05E8}\u{05D9}\u{05EA}"
    let hindi: String =
        "\u{092F}\u{0939}\u{0932}\u{094B}\u{0917}\u{0939}\u{093F}\u{0928}\u{094D}\u{0926}\u{0940}\u{0915}\u{094D}\u{092F}\u{094B}\u{0902}\u{0928}\u{0939}\u{0940}\u{0902}\u{092C}\u{094B}\u{0932}\u{0938}\u{0915}\u{0924}\u{0947}\u{0939}\u{0948}\u{0902}"
    let japanese: String = "\u{306A}\u{305C}\u{307F}\u{3093}\u{306A}\u{65E5}\u{672C}\u{8A9E}\u{3092}\u{8A71}\u{3057}\u{3066}\u{304F}\u{308C}\u{306A}\u{3044}\u{306E}\u{304B}"
    let korean: String =
        "\u{C138}\u{ACC4}\u{C758}\u{BAA8}\u{B4E0}\u{C0AC}\u{B78C}\u{B4E4}\u{C774}\u{D55C}\u{AD6D}\u{C5B4}\u{B97C}\u{C774}\u{D574}\u{D55C}\u{B2E4}\u{BA74}\u{C5BC}\u{B9C8}\u{B098}\u{C88B}\u{C744}\u{AE4C}"
    let russian: String =
        "\u{043F}\u{043E}\u{0447}\u{0435}\u{043C}\u{0443}\u{0436}\u{0435}\u{043E}\u{043D}\u{0438}\u{043D}\u{0435}\u{0433}\u{043E}\u{0432}\u{043E}\u{0440}\u{044F}\u{0442}\u{043F}\u{043E}\u{0440}\u{0443}\u{0441}\u{0441}\u{043A}\u{0438}"
    let spanish: String =
        "\u{0050}\u{006F}\u{0072}\u{0071}\u{0075}\u{00E9}\u{006E}\u{006F}\u{0070}\u{0075}\u{0065}\u{0064}\u{0065}\u{006E}\u{0073}\u{0069}\u{006D}\u{0070}\u{006C}\u{0065}\u{006D}\u{0065}\u{006E}\u{0074}\u{0065}\u{0068}\u{0061}\u{0062}\u{006C}\u{0061}\u{0072}\u{0065}\u{006E}\u{0045}\u{0073}\u{0070}\u{0061}\u{00F1}\u{006F}\u{006C}"
    let vietnamese: String =
        "\u{0054}\u{1EA1}\u{0069}\u{0073}\u{0061}\u{006F}\u{0068}\u{1ECD}\u{006B}\u{0068}\u{00F4}\u{006E}\u{0067}\u{0074}\u{0068}\u{1EC3}\u{0063}\u{0068}\u{1EC9}\u{006E}\u{00F3}\u{0069}\u{0074}\u{0069}\u{1EBF}\u{006E}\u{0067}\u{0056}\u{0069}\u{1EC7}\u{0074}"

    let jBlockL: String = "\u{0033}\u{5E74}\u{0042}\u{7D44}\u{91D1}\u{516B}\u{5148}\u{751F}"
    let jBlockM: String =
        "\u{5B89}\u{5BA4}\u{5948}\u{7F8E}\u{6075}\u{002D}\u{0077}\u{0069}\u{0074}\u{0068}\u{002D}\u{0053}\u{0055}\u{0050}\u{0045}\u{0052}\u{002D}\u{004D}\u{004F}\u{004E}\u{004B}\u{0045}\u{0059}\u{0053}"
    let jBlockN: String =
        "\u{0048}\u{0065}\u{006C}\u{006C}\u{006F}\u{002D}\u{0041}\u{006E}\u{006F}\u{0074}\u{0068}\u{0065}\u{0072}\u{002D}\u{0057}\u{0061}\u{0079}\u{002D}\u{305D}\u{308C}\u{305E}\u{308C}\u{306E}\u{5834}\u{6240}"
    let jBlockO: String = "\u{3072}\u{3068}\u{3064}\u{5C4B}\u{6839}\u{306E}\u{4E0B}\u{0032}"
    let jBlockP: String = "\u{004D}\u{0061}\u{006A}\u{0069}\u{3067}\u{004B}\u{006F}\u{0069}\u{3059}\u{308B}\u{0035}\u{79D2}\u{524D}"
    let jBlockQ: String = "\u{30D1}\u{30D5}\u{30A3}\u{30FC}\u{0064}\u{0065}\u{30EB}\u{30F3}\u{30D0}"
    let jBlockR: String = "\u{305D}\u{306E}\u{30B9}\u{30D4}\u{30FC}\u{30C9}\u{3067}"

    let plain: String = "\u{002D}\u{003E}\u{0020}\u{0024}\u{0031}\u{002E}\u{0030}\u{0030}\u{0020}\u{003C}\u{002D}"
    let multiscalar: String = "🇨🇦"
    let idna: String = "погода-в-египте.рф.com"

    let egyptianCode: String = "egbpdaj6bu4bxfgehfvwxn"
    let chineseSimplifiedCode: String = "ihqwcrb4cv8a8dqg056pqjye"
    let chineseTraditionalCode: String = "ihqwctvzc91f659drss3x8bo0yb"
    let czechCode: String = "Proprostnemluvesky-uyb24dma41a"
    let hebrewCode: String = "4dbcagdahymbxekheh6e0a7fei0b"
    let hindiCode: String = "i1baa7eci9glrd9b2ae1bj0hfcgg6iyaf8o0a1dig0cd"
    let japaneseCode: String = "n8jok5ay5dzabd5bym9f0cm5685rrjetr6pdxa"
    let koreanCode: String = "989aomsvi5e83db1d2a355cv1e0vak1dwrv93d5xbh15a0dt30a5jpsd879ccm6fea98c"
    let russianCode: String = "b1abfaaepdrnnbgefbadotcwatmq2g4l"
    let spanishCode: String = "PorqunopuedensimplementehablarenEspaol-fmd56a"
    let vietnameseCode: String = "TisaohkhngthchnitingVit-kjcr8268qyxafd2f1b9g"

    let jBlockLCode: String = "3B-ww4c5e180e575a65lsy2b"
    let jBlockMCode: String = "-with-SUPER-MONKEYS-pc58ag80a8qai00g7n9n"
    let jBlockNCode: String = "Hello-Another-Way--fc4qua05auwb3674vfr0b"
    let jBlockOCode: String = "2-u9tlzr9756bt3uc0v"
    let jBlockPCode: String = "MajiKoi5-783gue6qz075azm5e"
    let jBlockQCode: String = "de-jg4avhby1noc0d"
    let jBlockRCode: String = "d9juau41awczczp"

    let plainCode: String = "-> $1.00 <--"
    let multiscalarCode: String = "e77hd"

    let idnaCode: String = "xn-----6kcjcecmb3a1dbkl9b.xn--p1ai.com"

    /// https://tools.ietf.org/html/rfc3492#section-7

    func testEncodingCorrectness() {
        XCTAssert(egyptian.punycodeEncoded == egyptianCode)
        XCTAssert(chineseSimplified.punycodeEncoded == chineseSimplifiedCode)
        XCTAssert(chineseTraditional.punycodeEncoded == chineseTraditionalCode)
        XCTAssert(czech.punycodeEncoded == czechCode)
        XCTAssert(hebrew.punycodeEncoded == hebrewCode)
        XCTAssert(hindi.punycodeEncoded == hindiCode)
        XCTAssert(japanese.punycodeEncoded == japaneseCode)
        XCTAssert(korean.punycodeEncoded == koreanCode)
        XCTAssert(russian.punycodeEncoded == russianCode)
        XCTAssert(spanish.punycodeEncoded == spanishCode)
        XCTAssert(vietnamese.punycodeEncoded == vietnameseCode)

        XCTAssert(jBlockL.punycodeEncoded == jBlockLCode)
        XCTAssert(jBlockM.punycodeEncoded == jBlockMCode)
        XCTAssert(jBlockN.punycodeEncoded == jBlockNCode)
        XCTAssert(jBlockO.punycodeEncoded == jBlockOCode)
        XCTAssert(jBlockP.punycodeEncoded == jBlockPCode)
        XCTAssert(jBlockQ.punycodeEncoded == jBlockQCode)
        XCTAssert(jBlockR.punycodeEncoded == jBlockRCode)

        XCTAssert(multiscalar.punycodeEncoded == multiscalarCode)
        XCTAssert(plain.punycodeEncoded == plainCode)

        XCTAssert(idna.idnaEncoded == idnaCode)
    }

    func testDecodingCorrectness() {
        XCTAssert(egyptianCode.punycodeDecoded == egyptian)
        XCTAssert(chineseSimplifiedCode.punycodeDecoded == chineseSimplified)
        XCTAssert(chineseTraditionalCode.punycodeDecoded == chineseTraditional)
        XCTAssert(czechCode.punycodeDecoded == czech)
        XCTAssert(hebrewCode.punycodeDecoded == hebrew)
        XCTAssert(hindiCode.punycodeDecoded == hindi)
        XCTAssert(japaneseCode.punycodeDecoded == japanese)
        XCTAssert(koreanCode.punycodeDecoded == korean)
        XCTAssert(russianCode.punycodeDecoded == russian)
        XCTAssert(spanishCode.punycodeDecoded == spanish)
        XCTAssert(vietnameseCode.punycodeDecoded == vietnamese)

        XCTAssert(jBlockLCode.punycodeDecoded == jBlockL)
        XCTAssert(jBlockMCode.punycodeDecoded == jBlockM)
        XCTAssert(jBlockNCode.punycodeDecoded == jBlockN)
        XCTAssert(jBlockOCode.punycodeDecoded == jBlockO)
        XCTAssert(jBlockPCode.punycodeDecoded == jBlockP)
        XCTAssert(jBlockQCode.punycodeDecoded == jBlockQ)
        XCTAssert(jBlockRCode.punycodeDecoded == jBlockR)

        XCTAssert(multiscalarCode.punycodeDecoded == multiscalar)
        XCTAssert(plainCode.punycodeDecoded == plain)

        XCTAssert(idnaCode.idnaDecoded == idna)
    }

    func testInvalidPunycodeIsNotFatal() {
        let invalidPunycode: String = "xn--g"
        XCTAssertNoThrow(invalidPunycode.idnaDecoded)
    }

    /// Issue #78: malformed punycode must decode to nil, never to garbage characters.

    func testDecodingIncompleteDigitSequenceReturnsNil() {
        /// RFC 3492: the input ends in the middle of a variable-length integer
        XCTAssertNil("y".punycodeDecoded)
        XCTAssertNil("y-z".punycodeDecoded)
        XCTAssertNil("a-b-c-d".punycodeDecoded)
    }

    func testDecodingC1ControlCharactersReturnsNil() {
        /// "abcd" decodes to U+0080-range C1 control characters, which never
        /// appear in legitimate text
        XCTAssertNil("abcd".punycodeDecoded)
    }

    func testDecodingInvalidDigitsReturnsNil() {
        XCTAssertNil("-".punycodeDecoded)
        XCTAssertNil("аб".punycodeDecoded)
    }

    func testDecodingOverflowReturnsNilInsteadOfTrapping() {
        /// RFC 3492 section 6.4 requires overflow detection; unchecked
        /// arithmetic would trap on inputs like these ('9' is the highest
        /// digit value, so the weight keeps multiplying without a break)
        XCTAssertNil(String(repeating: "9", count: 30).punycodeDecoded)
        XCTAssertNil(String(repeating: "z", count: 64).punycodeDecoded)
    }

    func testDecodingValidEdgeCases() {
        /// RFC 3492: all-ASCII input encodes to "<input>-", so these round-trip
        XCTAssertEqual("-".punycodeEncoded, "--")
        XCTAssertEqual("--".punycodeDecoded, "-")
        XCTAssertEqual("y".punycodeEncoded, "y-")
        XCTAssertEqual("y-".punycodeDecoded, "y")
        /// Valid samples from the issue #78 report
        XCTAssertEqual("90a".punycodeDecoded, "б")
        XCTAssertEqual("--9sb".punycodeDecoded, "б-")
        XCTAssertEqual("--btb".punycodeDecoded, "-б")
        XCTAssertEqual("80acde".punycodeDecoded, "абвг")
        XCTAssertEqual("abcd-u8d".punycodeDecoded, "ёabcd")
        XCTAssertEqual("abcd-y8d".punycodeDecoded, "abcdё")
        XCTAssertEqual("a-b-c-d-lng".punycodeDecoded, "ёa-b-c-d")
        XCTAssertEqual("-a-b-c-d-vbhklm5q".punycodeDecoded, "ёпрст-a-b-c-d")
        XCTAssertEqual("a-b-c-d--3bhklm5q".punycodeDecoded, "a-b-c-d-ёпрст")
        XCTAssertEqual("bcher-kva".punycodeDecoded, "bücher")
        XCTAssertEqual("80abnmycp7evc".punycodeDecoded, "обращения")
        XCTAssertEqual("r1aadaaghijkl".punycodeDecoded, "ттуууфхцчшщ")
    }

    /// Issue #4: punycodeEncoded is raw RFC 3492 (single label, no ACE prefix);
    /// idnaEncoded is for hostnames.

    func testPunycodeEncodedIsRawRFC3492() {
        XCTAssertEqual("goo.gl".punycodeEncoded, "goo.gl-")
        XCTAssertEqual("goo.gl".idnaEncoded, "goo.gl")
        XCTAssertEqual("example.com".idnaEncoded, "example.com")
    }

    func testIDNAEncodingAppliesUnicodeMapping() {
        /// Full-width forms, alternate dots, and case are mapped before encoding
        XCTAssertEqual("ＧＯＯ．ＧＬ".idnaEncoded, "goo.gl")
        XCTAssertEqual("example。com".idnaEncoded, "example.com")
        XCTAssertEqual("example｡com".idnaEncoded, "example.com")
        XCTAssertEqual("EXAMPLE.COM".idnaEncoded, "example.com")
        XCTAssertEqual("日本語。ＪＰ".idnaEncoded, "xn--wgv71a119e.jp")
        /// NFC: the decomposed form (u + combining diaeresis) encodes
        /// identically to the composed form
        XCTAssertEqual("bu\u{0308}cher.de".idnaEncoded, "xn--bcher-kva.de")
        XCTAssertEqual("bücher.de".idnaEncoded, "xn--bcher-kva.de")
    }

    func testIDNADecodingAcceptsUppercaseACEPrefix() {
        XCTAssertEqual("XN--BCHER-KVA.de".idnaDecoded, "bücher.de")
    }

    /// idnaEncodedURL / idnaDecodedURL: only the host portion of a URL-shaped
    /// string is transformed; scheme, userinfo, port, path, query, and
    /// fragment pass through unchanged.

    func testIDNAEncodedURL() {
        XCTAssertEqual(
            "http://www.ラーメン.寿司.co.jp".idnaEncodedURL,
            "http://www.xn--4dkp5a8a.xn--sprr0q.co.jp"
        )
        XCTAssertEqual("https://test.com".idnaEncodedURL, "https://test.com")
        XCTAssertEqual(
            "http://ラーメン.jp/メニュー?q=寿司#上".idnaEncodedURL,
            "http://xn--4dkp5a8a.jp/メニュー?q=寿司#上"
        )
        XCTAssertEqual("http://ラーメン.jp:8080/".idnaEncodedURL, "http://xn--4dkp5a8a.jp:8080/")
        XCTAssertEqual("http://user@ラーメン.jp/".idnaEncodedURL, "http://user@xn--4dkp5a8a.jp/")
        XCTAssertEqual("http://[::1]:8080/".idnaEncodedURL, "http://[::1]:8080/")
        XCTAssertEqual("//ラーメン.jp/path".idnaEncodedURL, "//xn--4dkp5a8a.jp/path")
        XCTAssertEqual("www.ラーメン.jp/path".idnaEncodedURL, "www.xn--4dkp5a8a.jp/path")
        /// Invalid schemes are not treated as scheme delimiters
        XCTAssertEqual("1a://ラーメン.jp/x".idnaEncodedURL, "1a://ラーメン.jp/x")
        XCTAssertEqual("://test.com".idnaEncodedURL, "://test.com")
        /// "://" inside the query must not be mistaken for a scheme delimiter
        XCTAssertEqual(
            "test.com/?u=http://ラーメン.jp".idnaEncodedURL,
            "test.com/?u=http://ラーメン.jp"
        )
    }

    func testIDNADecodedURL() {
        XCTAssertEqual(
            "http://www.xn--4dkp5a8a.xn--sprr0q.co.jp".idnaDecodedURL,
            "http://www.ラーメン.寿司.co.jp"
        )
        XCTAssertEqual("http://xn--4dkp5a8a.jp:8080/x".idnaDecodedURL, "http://ラーメン.jp:8080/x")
        XCTAssertEqual("http://user@xn--4dkp5a8a.jp/".idnaDecodedURL, "http://user@ラーメン.jp/")
        XCTAssertEqual("http://[::1]/".idnaDecodedURL, "http://[::1]/")
        XCTAssertEqual("https://test.com".idnaDecodedURL, "https://test.com")
    }

    func testIDNAURLRoundTrip() {
        let url: String = "http://user@www.ラーメン.寿司.co.jp:8080/メニュー?q=寿司#上"
        guard let encoded: String = url.idnaEncodedURL else {
            return XCTFail("encoding failed")
        }
        XCTAssertEqual(encoded.idnaDecodedURL, url)
    }

    func testIDNAURLInvalidInputReturnsNil() {
        /// Malformed punycode in the host
        XCTAssertNil("http://xn--abcd.jp".idnaDecodedURL)
        /// C1 control character in the host
        XCTAssertNil("http://a\u{0085}b.jp".idnaEncodedURL)
        /// Unterminated IPv6 literal
        XCTAssertNil("http://[::1/".idnaEncodedURL)
    }

    //    func testFoo1() {
    //        var sushi: String = "寿司"
    //
    //        sushi = sushi.idnaEncoded!
    //        print(sushi)  // xn--sprr0q
    //
    //        sushi = sushi.idnaDecoded!
    //        print(sushi)  // "寿司"
    //    }
    //
    //    func testFoo2() {
    //        var sushi: String = "寿司"
    //
    //        sushi = sushi.punycodeEncoded!
    //        print(sushi)  // sprr0q
    //
    //        sushi = sushi.punycodeDecoded!
    //        print(sushi)  // "寿司"
    //    }
    //
    //    func testFoo3() {
    //        var sushi: Substring = "寿司大好き".prefix(2)
    //        print(sushi)  // "寿司"
    //
    //        var sushiStr = sushi.idnaEncoded!
    //        print(sushiStr)  // xn--sprr0q
    //
    //        sushiStr = sushiStr.idnaDecoded!
    //        print(sushiStr)  // "寿司"
    //    }
    //
    //    func testFoo4() {
    //        var sushi: Substring = "寿司大好き".prefix(2)
    //        print(sushi)  // "寿司"
    //
    //        var sushiStr = sushi.punycodeEncoded!
    //        print(sushiStr)  // sprr0q
    //
    //        sushiStr = sushiStr.punycodeDecoded!
    //        print(sushiStr)  // "寿司"
    //    }
}
