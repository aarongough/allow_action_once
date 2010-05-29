class TestsController < ApplicationController

  # GET /tests/show
  def show
    head :success
  end
  
  # POST /tests/upmod/1
  def upmod
    allow_action_once
    head :success
  end
  
  # POST /tests/downmod/1
  def downmod
    allow_action_once
    head :success
  end

end