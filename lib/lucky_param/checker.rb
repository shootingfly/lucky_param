# frozen_string_literal: true

module LuckyParam
  CHECKER = {
    NONE: [
      ->(_obj) { true }
    ],
    String: [
      ->(obj) { !obj.empty? },
      "must be valid String"
    ],
    Integer: [
      ->(obj) { obj.to_i.to_s == obj },
      "must be valid Integer"
    ],
    Float: [
      ->(obj) { obj.to_f.to_s == obj },
      "must be valid Float"
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
