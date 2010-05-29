class TestsController < ApplicationController

  #allow_action_once :only => [:protected_action]

  # GET /tests/show
  def show
    head :success
  end
  
  # POST /tests/protected_action/1
  def protected_action
    head :success
  end

end