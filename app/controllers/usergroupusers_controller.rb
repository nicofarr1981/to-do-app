class UsergroupusersController < ApplicationController

    def new
        @usergroupusers = Usergroupuser.new
    end

end
