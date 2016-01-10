require 'test_helper'

class ChapterTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  #
  test "orphaned Chapter objects don't belong to a State object" do
    chapters = Chapter.orphaned

    chapters.each do |chapter|
      assert chapter.state.nil? == true, "State associated with chapter #{chapter.id}"
    end
  end

  test "adopted Chapter objects do belong to a State object" do
    chapters = Chapter.adopted

    chapters.each do |chapter|
      assert chapter.state.nil? == false, "State not associated with chapter: #{chapter.inspect}"
    end
  end
end
