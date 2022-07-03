class UsergroupusersController < ApplicationController

    def new
        @usergroupuser = Usergroupuser.new
        @usergroupuser["usergroup_id"] = params["usergroup_id"]
        @usergroupuser["user_id"] = params["user_id"]
        @usergroupuser.save
        flash["notice"] = "User successfully added."
        redirect_to "/usergroups/"+params["usergroup_id"]+"/edit?"
    end

    def destroy
        if @current_user
            @usergroupuser = Usergroupuser.find_by({ "id" => params["id"] })
            usergroup_id = @usergroupuser["usergroup_id"]
            @usergroupuser.destroy
            flash["notice"] = "User successfully removed."
            redirect_to "/usergroups/"+usergroup_id.to_s+"/edit?"
        else
            flash["notice"] = "Login first."
            redirect_to "/login"
        end
    end

end
