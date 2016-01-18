require 'test_helper'

class ChapterTest < ActiveSupport::TestCase
  test "orphaned Chapter objects don't belong to a State object" do
    chapters = Chapter.orphaned

    chapters.each do |chapter|
      assert chapter.state.nil?, "State associated with chapter #{chapter.id}"
    end
  end

  test "adopted Chapter objects do belong to a State object" do
    chapters = Chapter.adopted

    chapters.each do |chapter|
      assert_not chapter.state.nil?, "State not associated with chapter: #{chapter.inspect}"
    end
  end

  test "name is present" do
    chapter = Chapter.new

    assert_not chapter.save, "name has to be present"
  end

  test "name is unique" do
    existing_chapter = Chapter.take
    new_chapter = Chapter.new

    new_chapter.name= existing_chapter.name

    assert_not new_chapter.save, "name has to be unique"
  end
end
