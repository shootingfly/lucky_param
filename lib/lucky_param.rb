# frozen_string_literal: true

require "active_support/core_ext/object/blank"

require_relative "./lucky_param/version"
require_relative "./lucky_param/checker"

module LuckyParam
  class ParamMissError < StandardError; end
  class ParamFormatError < StandardError; end
  class UnknownCheckerError < StandardError; end

  def required(column, checker_type)
    raise ParamMissError.new("Missing Params: #{column}") if params[column].blank?
    message = checker_message(column, checker_type)
    raise ParamFormatError.new("Wrong Params Format: #{message}") if message
  end

  def optional(column, checker_type)
    return if params[column].blank?
    message = checker_message(column, checker_type)
    raise ParamFormatError.new("Wrong Params Format: #{message}") if message
  end

  private

    def checker_message(column, checker_type)
      checker = CUSTOM_CHECKER[checker_type] if LuckyParam.const_defined?(:CUSTOM_CHECKER)
      checker ||= CHECKER.fetch(checker_type) {
        raise UnknownCheckerError, "Unknown checker `#{checker_type}`, try to define checker with const `LuckyParam::CUSTOM_CHECKER`"
      }
      result = checker[0].call(params[column])
      result ? nil : "#{column} #{checker[1]}"
    end
end
