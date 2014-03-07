require 'test_helper'

class TodoTest < ActiveSupport::TestCase
  test "Todo attributes must not be empty" do
    todo = Todo.new
    assert todo.invalid?
  end
end
