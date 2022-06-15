class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user_exists = User.find_by({ "email" => params["user"]["email"] })
    if @user_exists
      flash["notice"] = "You are already signed up"
      redirect_to "/login"
    else
      @user = User.new
      @user["first_name"] = params["user"]["first_name"]
      @user["last_name"] = params["user"]["last_name"]
      @user["email"] = params["user"]["email"]
      @user["password"] = BCrypt::Password.create(params["user"]["password"])
      @user.save
      redirect_to "/todolists"
    end
  end

end
