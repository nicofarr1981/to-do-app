class UsergroupsController < ApplicationController
    def index
        if @current_user
            @usergroups = Usergroup.where({ 
                "owning_user_id" => @current_user["id"]
              })
        else
            flash["notice"] = "Login first."
            redirect_to "/login"
        end
    end

    def new
        @usergroup = Usergroup.new
        @usergroupuser = Usergroupuser.new
    end
    
    def create
        @usergroup = Usergroup.new
        @usergroup["name"] = params["usergroup"]["name"]
        @usergroup["owning_user_id"] = @current_user["id"]          
        @usergroup.save
        @usergroupuser = Usergroupuser.new
        @usergroupuser["usergroup_id"] = @usergroup["id"]
        @usergroupuser["user_id"] = @current_user["id"]
        @usergroupuser.save 
        redirect_to "/usergroups"
    end

    def destroy
        if @current_user
            @usergroup = Usergroup.find_by({ "owning_user_id" => @current_user["id"] })
            @usergroupusers = Usergroupuser.find_by({ "usergroup_id" => @usergroup["id"] })
            @usergroupusers.destroy
            @usergroup.destroy
            flash["notice"] = "User group successfully deleted."
            redirect_to "/usergroups"
        else
            flash["notice"] = "Login first."
            redirect_to "/login"
        end
    end

end
