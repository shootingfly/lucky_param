# frozen_string_literal: true

require_relative "./lucky_param/version"
require_relative "./lucky_param/checker"

module LuckyParam
  class ParamMissError < StandardError
  end

  class ParamFormatError < StandardError
  end

  class UnknownCheckerError < StandardError
  end

  def required(column, checker_type)
    required_optional(:required, column, checker_type)
  end

  def optional(column, checker_type)
    required_optional(:optional, column, checker_type)
  end

  private

    def required_optional(type, column, checker_type)
      unless params[column]
        return if type == :optional
        raise ParamMissError, "Missing Params: #{column}"
      end
      message = checker_message(column, checker_type)
      if message
        raise ParamFormatError, "Wrong Params Format: #{message}"
      end
    end

    def checker_message(column, checker_type)
      checker = CUSTOM_CHECKER[checker_type] if LuckyParam.const_defined?(:CUSTOM_CHECKER)
      checker ||= CHECKER.fetch(checker_type) {
        raise UnknownCheckerError, "Unknown checker `#{checker_type}`, try to define checker with const `LuckyParam::CUSTOM_CHECKER`"
      }
      result = checker[0].call(params[column])
      result ? nil : "#{column} #{checker[1]}"
    end
end
