require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "creates a team when a user signs up" do
    assert_difference('Team.count') do
      User.create(name:"NameTest",password:"TestPass",password_confirmation:"TestPass",email:"perico@palotes.com")
    end
  end 

  test "assigns proper team when a new user is invited" do
    # Create a initial user
    inviter = Fabricate(:user)

    assert_no_difference('Team.count') do
      # Send an invitation (for test purposes, it only creates it)
      User.invite!({email: "example@example.org"}, inviter) do |u|
        u.skip_invitation = true
      end

      # We make sure the invitation created a new user
      @invitee = User.last
      assert inviter != @invitee

      # The invitee accepts the invitation
      User.accept_invitation!(
          invitation_token:       @invitee.invitation_token,
          password:               "secret",
          password_confirmation:  "secret",
          name:                   "Steve"
      )
    end

    # Both users should now belong to the same team
    assert inviter.team == @invitee.team    
  end

end
