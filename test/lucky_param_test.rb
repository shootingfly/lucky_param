# frozen_string_literal: true

require_relative "./test_helper"
require_relative "./demo_controller"

class LuckyParamTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::LuckyParam::VERSION
  end

  def test_miss_param
    params = {
      password: "123456"
    }
    assert_raises ::LuckyParam::ParamMissError do
      DemoController.new(params).create
    end
  end

  def test_wrong_format
    params = {
      username: "test",
      password: "1234"
    }
    assert_raises ::LuckyParam::ParamFormatError do
      DemoController.new(params).create
    end
  end

  def test_wrong_format
    params = {
      username: "test",
      password: "123456"
    }
    result = DemoController.new(params).create
    assert_equal params[:username], result
  end
end
