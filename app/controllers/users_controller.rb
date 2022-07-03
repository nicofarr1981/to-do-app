class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def apply
    @user = User.new
    @users = User.pluck(:first_name, :last_name, :id)
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
