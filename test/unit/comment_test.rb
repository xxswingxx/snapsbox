require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  setup do
    @input_attributes = {
      name: "psseicro",
      password: "pimbas",
      password_confirmation: "pimbas",
      email: "wessbah@gssuri.com"      
    }
  end
  
  test "it is not possible to create an empty comment" do
    b = Button.new(title: "TestTitle", url: "http://www.endeve.com")
    c1 = b.comments.new
    assert c1.invalid?
    c2 = b.comments.new(author: User.create(@input_attributes))
    assert c2.invalid?
  end

  test "it is not possible to create an anonymous comment" do
    b = Button.new(title: "TestTitle", url: "http://www.endeve.com")    
    c = b.comments.new(body: "prueba")
    assert c.invalid?
  end
end
