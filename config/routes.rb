Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get "/", :controller => "todos", :action => "index"
  get "/login", :controller => "sessions", :action => "new"
  get "/logout", :controller => "sessions", :action => "destroy"
  get "todos/:id/edit", to: "todos#edit", as: "edit_todo"
  patch "todos/:id", to: "todos#update", as: "update_todo"
  patch "todos/:id/update", to: "todos#update_status", as: "update_status_todo"
  get "/delete", :controller => "todos", :action => "destroy"

  resources "todos"
  resources "sessions"
  resources "users"
end
