require 'rails_helper'

RSpec.describe User, type: :model do
    
    subject(:user) do
      FactoryBot.build(:user,
        username: "jonathan@fakesite.com",
        password: "good_password")
    end

  describe "validations" do 
      it { should validate_presence_of(:username) }
      it { should validate_presence_of(:password_digest) }
      it { should validate_length_of(:password).is_at_least(6) }

      describe "uniqueness" do 
        before :each do 
          create :user 
        end 
          it { should validate_uniqueness_of(:username) }
      end
  end 

  describe "User#password=" do 
    # let(:user) { User.new(username: 'Bob', password: 'hello2') }

    it "should set a password_digest for a user" do 
      expect(user.password_digest).to_not be_nil 
    end 
  end 

  # it "creates a session token before validation" do
  #   user.valid?
  #   expect(user.session_token).to_not be_nil
  # end

  describe "User#reset_session_token" do 
    # let(:user) { User.new(username: 'Bob', password: 'hello2') }
    it "should set a session token for a user" do 
      expect(user.reset_session_token).to_not be_nil 
    end 
  end

  describe "User#is_password?" do 
    it "returns true for a correct password" do 
      expect(user.is_password?("good_password")).to be true 
    end 

    it "returns false for an incorrect password" do 
      expect(user.is_password?("bad_password")).to be false
    end 
  end 

  describe "User#ensure_session_token" do 
    it "should set a session token for a user if it does not have one" do
      expect(user.session_token).to be_nil 
      user.save! 
      expect(user.session_token).to_not be_nil
    end
  end 

  describe "User#reset_session_token" do 
    it "should reset the session token for a user" do
      user.save!
      token = user.session_token
      user.reset_session_token
      expect(user.session_token).to_not eq(token)
    end 
  end 

  describe "User::find_by_credentials" do 
    it "should return a user with a matching password and username" do 
      user.save!
      expect(User.find_by_credentials(user.username, "good_password")).to eq(user)
    end 

    it "should return nil if a non matching password or username is given" do 
      user.save!
      expect(User.find_by_credentials(user.username, "bad_password")).to be_nil
    end 
  end 
end
