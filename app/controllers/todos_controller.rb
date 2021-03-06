class TodosController < ApplicationController
    def index
        if @current_user
            @todos = Todo.where({ 
                "user_id" => @current_user["id"],
                "todolist_id" => params["todolist_id"]
              }).sort_by(&:duedate)
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
            @todo["todolist_id"] = params["todo"]["todolist_id"]
            if @todo["duedate"] >= Time.new.strftime("%Y-%m-%d")
                @todo.save
                flash["notice"] = "To-do created successfully." 
                redirect_to "/todos?todolist_id="+@todo["todolist_id"].to_s
            else
                flash["notice"] = "Due date in the past" 
                redirect_to "/todos/new?todolist_id="+@todo["todolist_id"].to_s
            end
        else
            flash["notice"] = "Login first."
            redirect_to "/login"
        end
 
    end

    def edit
        if @current_user
            @todo = Todo.find_by({ "id" => params["id"] })
            if @todo["done"] == false
                render :edit
            else
                flash["notice"] = "Uncheck to-do before edit."
                redirect_to "/todos?todolist_id="+@todo["todolist_id"].to_s
            end
        else
            flash["notice"] = "Login first."
            redirect_to "/login"
        end
    end
    
    def update
        @todo = Todo.find(params[:id])
        if params["todo"]["duedate"] >= Time.new.strftime("%Y-%m-%d")
            if @todo.update(params.require(:todo).permit(:description, :duedate))
                flash["notice"] = "To-do successfully updated."
                redirect_to "/todos?todolist_id="+@todo["todolist_id"].to_s
            else
                flash["notice"] = "To-do update failed."
                render :edit
            end
        else
            flash["notice"] = "To-do update failed. Due date in the past." 
            redirect_to "/todos?todolist_id="+@todo["todolist_id"].to_s
        end
    end

    def update_status
        if @current_user
            @todo = Todo.find(params[:id])
            if @todo["done"] == false
                @todo["done"] = true
                flash["notice"] = "To-do successfully checked off."
            else
                @todo["done"] = false
                flash["notice"] = "To-do successfully unchecked."
            end
            @todo.save
            redirect_to "/todos?todolist_id="+@todo["todolist_id"].to_s
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
            redirect_to "/todos?todolist_id="+@todo["todolist_id"].to_s
        else
            flash["notice"] = "Login first."
            redirect_to "/login"
        end
    end
end
