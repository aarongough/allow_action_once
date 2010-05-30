class TestsController < ActionController::Base

  allow_action_once :only => [:protected_action]

  # GET /tests/show
  def show
  end
  
  # POST /tests/protected_action/1
  def protected_action
  end

end