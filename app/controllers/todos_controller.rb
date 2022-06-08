class TodosController < ApplicationController
    def index
        if @current_user
            @todos = Todo.all
        else
            flash["notice"] = "Login first."
            redirect_to "/login"
        end
    end

    def new
        if @current_user
            @todo = Todo.new
        else
            flash["notice"] = "Login first."
            redirect_to "/login"
        end
    end

    def create
        if @current_user
            @todo = Todo.new
            @todo["description"] = params["todo"]["description"]
            @todo["duedate"] = params["todo"]["duedate"]
            @todo["done"] = false
            @todo["user_id"] = @current_user["id"]
            @todo.save
            flash["notice"] = "To-do created successfully."
            redirect_to "/todos"
        else
            flash["notice"] = "Login first."
            redirect_to "/login"
        end
 
    end

    def edit
        if @current_user
            @todo = Todo.find_by({ "id" => params["id"] })
            render :edit
        else
            flash["notice"] = "Login first."
            redirect_to "/login"
        end
    end
    
    def update
        @todo = Todo.find(params[:id])
        if @todo.update(params.require(:todo).permit(:description, :duedate))
            flash["notice"] = "To-do successfully updated."
            redirect_to "/todos"
        else
            flash["notice"] = "To-do update failed."
            render :edit
        end
    end

    def update_status
        if @current_user
            @todo = Todo.find(params[:id])
            @todo["done"] = true
            @todo.save
            flash["notice"] = "To-do successfully checked off."
            redirect_to "/todos"
        else
            flash["notice"] = "Login first."
            redirect_to "/login"
        end
    end

    def destroy
        if @current_user
            @todo = Todo.find_by({ "id" => params["id"] })
            @todo.destroy
            flash["notice"] = "To-do successfully deleted."
            redirect_to "/todos"
        else
            flash["notice"] = "Login first."
            redirect_to "/login"
        end
    end
end
