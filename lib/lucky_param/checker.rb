# frozen_string_literal: true

module LuckyParam
  CHECKER = {
    NONE: [
      ->(_obj) { true }
    ],
    String: [
      ->(obj) { obj.is_a?(String) },
      "must be valid String"
    ],
    Boolean: [
      ->(obj) { %w[true false 1 0].include?(obj.to_s) },
      "must be one of [true false 1 0]"
    ],
    Integer: [
      ->(obj) { obj.to_s =~ /\A(0|[1-9]\d*)\Z$/ },
      "must be valid Integer"
    ],
    Float: [
      ->(obj) { obj.to_s =~ /\A^[-+]?[0-9]+([,.][0-9]+)?\Z$/ },
      "must be valid Float"
    ],
    Number: [
      ->(obj) { Float(obj) rescue false }
    ],
    Email: [
      ->(obj) { obj =~ /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/ },
      "must be valid Email"
    ],
    Timestamp: [
      ->(obj) { obj =~ /^(\+|\-)?\d+$/ },
      "must be valid Timestamp"
    ],
    ArrayJSON: [
      lambda { |obj|
        begin
          JSON.parse(obj).is_a?(Array)
        rescue StandardError
          false
        end
      },
      "must be valid Array JSON"
    ],
    HashJSON: [
      lambda { |obj|
        begin
          JSON.parse(obj).is_a?(Hash)
        rescue StandardError
          false
        end
      },
      "must be valid Hash JSON"
    ]
  }.freeze
end
