Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get "/", :controller => "todolists", :action => "index"
  get "/login", :controller => "sessions", :action => "new"
  get "/logout", :controller => "sessions", :action => "destroy"
  get "todos/:id/edit", to: "todos#edit", as: "edit_todo"
  patch "todos/:id", to: "todos#update", as: "update_todo"
  get "todolists/:id/edit", to: "todolists#edit", as: "edit_todolist"
  get "/delete", :controller => "todolists", :action => "destroy"
  patch "todos/:id/update", to: "todos#update_status", as: "update_status_todo"
  get "/delete", :controller => "todos", :action => "destroy"

  resources "todos"
  resources "todolists"
  resources "sessions"
  resources "users"
end
