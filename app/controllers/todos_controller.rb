class TodosController < ApplicationController
    def index
        @todos = Todo.all
    end

    def new
        @todo = Todo.new
    end

    def create
        if @current_user
            @todo = Todo.new
            @todo["description"] = params["todo"]["description"]
            @todo["duedate"] = params["todo"]["duedate"]
            @todo["done"] = false
            @todo["user_id"] = @current_user["id"]
            @todo.save
        else
            flash["notice"] = "Login first."
        end
            redirect_to "/todos"
    end

    def destroy
        if @current_user
            @todo = Todo.find_by({ "id" => params["id"] })
            @todo.destroy
            redirect_to "/todos"
        end
    end
end
