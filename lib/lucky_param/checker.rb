# frozen_string_literal: true

module LuckyParam
  CHECKER = {
    NONE: [
      ->(params, column) { true }
    ],
    String: [
      ->(params, column) { params[column].is_a?(String) },
      "must be valid String"
    ],
    Boolean: [
      ->(params, column) { %w[true false 1 0].include?(params[column].to_s) },
      "must be one of [true false 1 0]"
    ],
    Integer: [
      ->(params, column) { params[column].to_s =~ /\A(0|[1-9]\d*)\Z$/ },
      "must be valid Integer"
    ],
    Float: [
      ->(params, column) { params[column].to_s =~ /\A^[-+]?[0-9]+([,.][0-9]+)?\Z$/ },
      "must be valid Float"
    ],
    Number: [
      lambda do |params, column|
        begin
          Float(params[column])
        rescue StandardError
          false
        end
      end
    ],
    Email: [
      ->(params, column) { params[column].to_s =~ /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/ },
      "must be valid Email"
    ],
    Timestamp: [
      ->(params, column) { params[column].to_s =~ /^(\+|\-)?\d+$/ },
      "must be valid Timestamp"
    ],
    ArrayJSON: [
      lambda do |params, column|
        begin
          params[column] = JSON.parse(params[column]) if params[column].is_a?(String)
          params[column].is_a?(Array)
        rescue StandardError
          false
        end
      end,
      "must be valid Array JSON"
    ],
    HashJSON: [
      lambda do |params, column|
        begin
          params[column] = JSON.parse(params[column]) if params[column].is_a?(String)
          params[column].respond_to?(:to_hash)
        rescue StandardError
          false
        end
      end,
      "must be valid Hash JSON"
    ]
  }.freeze
end
