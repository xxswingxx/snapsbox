require 'test_helper'
require 'bookmark_parser' # Necessary for bookmarks importing

class ButtonTest < ActiveSupport::TestCase

  test "a new button has a screenshot" do
    b = Button.create(title: "TestTitle", url: "http://www.endeve.com")
    assert b.screenshot, "The button generated doesnt have a screenshot"
  end

  test "first comment is created with a button if description is entered" do
    b1 = Button.create(title: "TestTitle", url: "http://www.endeve.com")
    assert_equal 0, b1.comments.count, 
      "A first comment is created with no description entered"

    b2 = Button.create(   title:        "TestTitle", 
                          url:          "http://www.endeve.com", 
                          description:  "Description test")
    assert_equal 1, b2.comments.count
      "A first comment is not created with description entered"
  end

  test "importing from a file adds proper new buttons" do
    @results = BookmarkParser.parseFile("#{Rails.root}/test/files/bookmarks.html")
    c = Button.count
    @results.each { |bm| Button.create(bm) }
    assert_equal c+@results.size, Button.count
  end

  test "should not process bookmarks not in HTML" do
    assert_nil BookmarkParser.parseFile("#{Rails.root}/test/files/bookmarks.txt")
  end

  test "a button with a wrong url have no screenshot" do
    b = Button.create(title: "TestTitle", url: "http://dir1.com")    
    assert_nil b.screenshot_filename, "Screenshot is defined even though url is wrong"
  end

end
