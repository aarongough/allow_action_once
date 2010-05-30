require File.expand_path(File.join(File.dirname(__FILE__), '..', 'test_helper.rb'))

class ExtendActionControllerTest < ActiveSupport::TestCase
  
  # Test that we have added an after_filter to ActionController::Base
  test "ActionController::Base.filter_chain should not be nil" do
    assert_not_nil ActionController::Base.filter_chain
  end
  
  test "ActionController::Base.filter_chain.length should not be greater than 0" do
    assert ActionController::Base.filter_chain.length > 0
  end
  
  # Test that ActionController::Base now has our new methods
  test "ActionController::Base should have allow_action_once method" do
    assert ActionController::Base.methods.include?("allow_action_once")
  end
  
end