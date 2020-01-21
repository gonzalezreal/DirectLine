@testable import DirectLine
import XCTest

final class AnyValueTests: XCTestCase {
    struct Model: Codable, Equatable {
        let value: AnyValue
    }

    func testDecodeString() throws {
        // given
        let data = """
        {
          "value" : "lorem ipsum"
        }
        """.data(using: .utf8)!
        let expected = Model(value: .string("lorem ipsum"))

        // when
        let result = try JSONDecoder().decode(Model.self, from: data)

        // then
        XCTAssertEqual(expected, result)
    }

    func testEncodeString() throws {
        // given
        let model = Model(value: .string("lorem ipsum"))
        let expected = """
        {
          "value" : "lorem ipsum"
        }
        """.data(using: .utf8)!
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]

        // when
        let result = try encoder.encode(model)

        // then
        XCTAssertEqual(expected, result)
    }

    func testDecodeBool() throws {
        // given
        let data = """
        {
          "value" : true
        }
        """.data(using: .utf8)!
        let expected = Model(value: .bool(true))

        // when
        let result = try JSONDecoder().decode(Model.self, from: data)

        // then
        XCTAssertEqual(expected, result)
    }

    func testEncodeBool() throws {
        // given
        let model = Model(value: .bool(true))
        let expected = """
        {
          "value" : true
        }
        """.data(using: .utf8)!
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]

        // when
        let result = try encoder.encode(model)

        // then
        XCTAssertEqual(expected, result)
    }

    func testDecodeInt() throws {
        // given
        let data = """
        {
          "value" : 42
        }
        """.data(using: .utf8)!
        let expected = Model(value: .int(42))

        // when
        let result = try JSONDecoder().decode(Model.self, from: data)

        // then
        XCTAssertEqual(expected, result)
    }

    func testEncodeInt() throws {
        // given
        let model = Model(value: .int(42))
        let expected = """
        {
          "value" : 42
        }
        """.data(using: .utf8)!
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]

        // when
        let result = try encoder.encode(model)

        // then
        XCTAssertEqual(expected, result)
    }

    func testDecodeDouble() throws {
        // given
        let data = """
        {
          "value" : 3.141592
        }
        """.data(using: .utf8)!
        let expected = Model(value: .double(3.141592))

        // when
        let result = try JSONDecoder().decode(Model.self, from: data)

        // then
        XCTAssertEqual(expected, result)
    }

    func testEncodeDouble() throws {
        // given
        let model = Model(value: .double(3))
        let expected = """
        {
          "value" : 3
        }
        """.data(using: .utf8)!
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]

        // when
        let result = try encoder.encode(model)

        // then
        XCTAssertEqual(expected, result)
    }

    func testDecodeDictionary() throws {
        // given
        let data = """
        {
          "foo" : ["bar", "baz"],
          "object" : {
            "foo": 42
          }
        }
        """.data(using: .utf8)!
        let expected: AnyValue = .dictionary([
            "foo": .array([.string("bar"), .string("baz")]),
            "object": .dictionary(["foo": .int(42)]),
        ])

        // when
        let result = try JSONDecoder().decode(AnyValue.self, from: data)

        // then
        XCTAssertEqual(expected, result)
    }

    func testEncodeDictionary() throws {
        // given
        let value: AnyValue = .dictionary([
            "foo": .array([.string("bar"), .string("baz")]),
            "object": .dictionary(["foo": .int(42)]),
        ])
        let expected = """
        {
          "foo" : [
            "bar",
            "baz"
          ],
          "object" : {
            "foo" : 42
          }
        }
        """.data(using: .utf8)!
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]

        // when
        let result = try encoder.encode(value)

        // then
        XCTAssertEqual(expected, result)
    }

    func testDecodeArray() throws {
        // given
        let data = """
        [
          true,
          {
            "foo" : "bar"
          }
        ]
        """.data(using: .utf8)!
        let expected: AnyValue = .array([
            .bool(true),
            .dictionary(["foo": .string("bar")]),
        ])

        // when
        let result = try JSONDecoder().decode(AnyValue.self, from: data)

        // then
        XCTAssertEqual(expected, result)
    }

    func testEncodeArray() throws {
        // given
        let value: AnyValue = .array([
            .bool(true),
            .dictionary(["foo": .string("bar")]),
        ])
        let expected = """
        [
          true,
          {
            "foo" : "bar"
          }
        ]
        """.data(using: .utf8)!
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]

        // when
        let result = try encoder.encode(value)

        // then
        XCTAssertEqual(expected, result)
    }

    func testDecodeNull() throws {
        // given
        let data = """
        {
          "value" : null
        }
        """.data(using: .utf8)!
        let expected = Model(value: .null)

        // when
        let result = try JSONDecoder().decode(Model.self, from: data)

        // then
        XCTAssertEqual(expected, result)
    }

    func testEncodeNull() throws {
        // given
        let model = Model(value: .null)
        let expected = """
        {
          "value" : null
        }
        """.data(using: .utf8)!
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]

        // when
        let result = try encoder.encode(model)

        // then
        XCTAssertEqual(expected, result)
    }

    static var allTests = [
        ("testDecodeString", testDecodeString),
        ("testEncodeString", testEncodeString),
        ("testDecodeBool", testDecodeBool),
        ("testEncodeBool", testEncodeBool),
        ("testDecodeInt", testDecodeInt),
        ("testEncodeInt", testEncodeInt),
        ("testDecodeDouble", testDecodeDouble),
        ("testEncodeDouble", testEncodeDouble),
        ("testDecodeDictionary", testDecodeDictionary),
        ("testEncodeDictionary", testEncodeDictionary),
        ("testDecodeArray", testDecodeArray),
        ("testEncodeArray", testEncodeArray),
        ("testDecodeNull", testDecodeNull),
        ("testEncodeNull", testEncodeNull),
    ]
}
