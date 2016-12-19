require 'test_helper'

class BookmarkTest < ActiveSupport::TestCase

  def setup
    @bookmark = Bookmark.new(title: 'Some Bookmark', link: 'bookmark@website.com')
  end

  test "has to be valid" do
    assert @bookmark.valid?
  end

  test "has to have a title" do
    @bookmark.title = " "
    assert_not @bookmark.valid?
  end

  test "has to have a link" do
    @bookmark.link = " "
    assert_not @bookmark.valid?
  end
end
