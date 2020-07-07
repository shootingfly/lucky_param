# frozen_string_literal: true

require "active_support/core_ext/object/blank"

require_relative "./lucky_param/version"
require_relative "./lucky_param/checker"

# An easy and extendable controller validator helper for Rails.
module LuckyParam
  class ParamMissError < StandardError; end
  class ParamFormatError < StandardError; end
  class UnknownCheckerError < StandardError; end

  def required(column, checker_type)
    raise ParamMissError.new("Missing Params: #{column}") if params[column].blank?

    check_param_format(column, checker_type)
  end

  def optional(column, checker_type)
    return if params[column].blank?

    check_param_format(column, checker_type)
  end

  private

    def check_param_format(column, checker_type)
      checker = CUSTOM_CHECKER[checker_type] if LuckyParam.const_defined?(:CUSTOM_CHECKER)
      checker ||= CHECKER.fetch(checker_type) do
        raise UnknownCheckerError.new("Unknown checker `#{checker_type}`, try to define checker with const `LuckyParam::CUSTOM_CHECKER`")
      end
      result = checker[0].call(params, column)
      raise ParamFormatError.new("Wrong Params Format: #{column} #{checker[1]}") unless result
    end
end
