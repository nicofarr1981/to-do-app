class TodolistsController < ApplicationController

    def index
        if @current_user
            @todolists = Todolist.where({ 
                "user_id" => @current_user["id"]
              })
        else
            flash["notice"] = "Login first."
            redirect_to "/login"
        end
    end

    def new
        if @current_user
            @todolist = Todolist.new
        else
            flash["notice"] = "Login first."
            redirect_to "/login"
        end
    end

    def create
        if @current_user
            @todolist = Todolist.new
            @todolist["title"] = params["todolist"]["title"]
            @todolist["user_id"] = @current_user["id"]
            @todolist.save
            flash["notice"] = "To-do list created successfully."
            redirect_to "/todolists"
        else
            flash["notice"] = "Login first."
            redirect_to "/login"
        end
    end

    def destroy
        if @current_user
            @todolist = Todolist.find_by({ "id" => params["id"] })
            @todolist.destroy
            flash["notice"] = "To-do list successfully deleted."
            redirect_to "/todolists"
        else
            flash["notice"] = "Login first."
            redirect_to "/login"
        end
    end

end
