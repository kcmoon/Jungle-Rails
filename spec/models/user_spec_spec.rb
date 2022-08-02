require 'rails_helper'

RSpec.describe User, type: :model do
  
    describe 'Validations' do
      #password and password confirmation not equal
      it "should fail if password and password confirmation are not entered" do
        @user = User.create( first_name:"Kenny", last_name:"Moon", email: "a@a.com", password: nil, password_confirmation: nil)
        expect(@user).to be_invalid
      end
      
      #password confirmation are required
      it "should fail if password and confirmation do not match" do
        @user = User.create( first_name:"Kenny", last_name:"Moon", email: "a@a.com", password: "password" password_confirmation: "passwrd")
        expect(@user).to be_invalid
      end 

      #passwords are required
      it "should fail if password missing" do
        @user = User.create( first_name:"Kenny", last_name:"Moon", email: "a@a.com", password: nil password_confirmation: nil)
        expect(@user).to be_invalid
      end    

      #password is 6 characters or longer
      it "should fail if password length < 6" do
        @user = User.create( first_name:"Kenny", last_name:"Moon", email: "a@a.com", password: "pass", password_confirmation: "pass")
        expect(@user).to be_invalid
      end  

      #email required
      it "should fail if email missing" do
        @user = User.create( first_name:"Kenny", last_name:"Moon", email: nil, password: "password", password_confirmation: "password")
        expect(@user).to be_invalid
      end   

      #email is unique in db 
      it "should fail if email is not unique, regardless of case" do
      @user1 = User.create( first_name:"Kenny", last_name:"Moon", email: "a@a.com", password: "password", password_confirmation: "password")
      expect(@user1).to be_valid
      @user2 = User.create( first_name:"John", last_name:"Doe", email: "a@a.com", password: "password", password_confirmation: "password")
      expect(@user2).to be_invalid
    end 

    #first name required
    it "should fail if first name missing" do
      @user = User.create( first_name: nil, last_name:"Moon", email: "a@a.com", password: "password", password_confirmation: "password")
      expect(@user).to be_invalid
    end

    #last name required
    it "should fail if last name missing" do
      @user = User.create( first_name:"Kenny", last_name: nil email: "a@a.com", password: "password", password_confirmation: "password")
      expect(@user).to be_invalid
    end

  describe ".authenticate_with_credentials" do

    it "Should return an instance of the user object if the email and password are correct" do
      @user = User.create(first_name: "Kenny", last_name: "Moon", email: "b@b.com", password: "password", password_confirmation: "password")
      expect(@user).to be_valid
      auth = User.authenticate_with_credentials(@user.email, "password")
      expect(auth).to eq(@user)
    end

    it "Should return nil if the email is not in the user database" do
      @user = User.create(first_name: "Kenny", last_name: "Moon", email: "b@b.com", password: "password", password_confirmation: "password")
      expect(@user).to be_valid
      auth = User.authenticate_with_credentials(@user.email, "test")
      expect(auth).to eq(nil)
    end

    it "Should authenticate the user even if there are extra spaces in the email field" do
      @user = User.create(first_name: "Kenny", last_name: "Moon", email: "b@b.com", password: "password", password_confirmation: "password")
      expect(@user).to be_valid
      auth = User.authenticate_with_credentials("b@b.com", "password")
      expect(auth).to eq(@user)
    end
    
    it "Should authenticate the user even if the email case does not match" do
      @user = User.create(first_name: "Kenny", last_name: "Moon", email: "ab@ab.com", password: "password", password_confirmation: "password")
      expect(@user).to be_valid
      auth = User.authenticate_with_credentials("AB@ab.com", "password")
      expect(auth).to eq(@user)
      auth2 = User.authenticate_with_credentials("Ab@b.COM", "password")
      expect(auth2).to eq(@user)
      @user2 = User.create(first_name: "Kenny", last_name: "Moon", email: "AB@AB.com", password: "password", password_confirmation: "password")
      expect(@user2).to be_valid
      auth3 = User.authenticate_with_credentials("AB@ab.com", "password")
      expect(auth3).to eq(@user2)
      auth4 = User.authenticate_with_credentials("Ab@Ab.COM", "password")
      expect(auth4).to eq(@user2)
    end

  end

end
