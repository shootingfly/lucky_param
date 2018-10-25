# frozen_string_literal: true

module LuckyParam
  CHECKER = {
    NONE: [
      ->(_obj) { true }
    ],
    String: [
      ->(obj) { obj =~ /\w/ },
      "must be valid String"
    ],
    Integer: [
      ->(obj) { obj =~ /\d+/ },
      "must be valid Integer"
    ],
    Email: [
      ->(obj) { obj =~ /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/ },
      "must be valid Email"
    ],
    Float: [
      ->(obj) { obj =~ /^(-?\d+)(\.\d+)?$/ },
      "must be valid Float"
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
