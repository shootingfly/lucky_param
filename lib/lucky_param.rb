# frozen_string_literal: true

require_relative "./lucky_param/version"
require_relative "./lucky_param/checker"

module LuckyParam
  class ParamMissError < StandardError
    def initialize(column)
      super "Missing Params: #{column}"
    end
  end

  class ParamFormatError < StandardError
    def initialize(message)
      super "Wrong Params Format: #{message}"
    end
  end

  def required(column, checker_type = :NONE)
    raise ParamMissError, column unless params.key?(column)

    message = _checker_message(column, checker_type)
    raise ParamFormatError, message if message.present?
  end

  def optional(column, checker_type = :NONE)
    return unless params.key?(column)

    message = _checker_message(column, checker_type)
    raise ParamFormatError, message if message.present?
  end

  def _checker_message(column, checker_type)
    checker = CUSTOM_CHECKER[checker_type] if LuckyParam.const_defined?(:CUSTOM_CHECKER)
    checker ||= CHECKER.fetch(checker_type) { raise "Unknown checker `#{checker_type}`, try to define checker with const `LuckyParam::CUSTOM_CHECKER`" }
    result = checker[0].call(params[column])
    return if result.present?

    checker[1]
  end
end
