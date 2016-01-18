require 'test_helper'

class StateTest < ActiveSupport::TestCase
	test "the truth" do
		assert true
	end

  test "populated scope returns states that have chapters associated with them" do
    states = State.populated

    states.each do |state|
      assert state.chapters.empty? == false, "State should have chapters associated with it"
    end
  end

  test "titleize_name calls titleize on state name" do
    name = "i am a name"
    state = State.new
    state.name = name

    assert state.titleize_name == name.titleize
  end
end
