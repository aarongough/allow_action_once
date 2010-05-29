require File.expand_path(File.join(File.dirname(__FILE__), '..', 'test_helper.rb'))

class TestsControllerTest < ActionController::TestCase
  
  @cookie_name = 'allowed_once_cookies_enabled'
  
  def setup
    @controller = TestsController.new
    @request = ActionController::TestRequest.new
    @response = ActionController::TestResponse.new
  end
  
  test "performing an unprotected action should return success" do
    get :show
    assert_response :success, @response.body.to_s
  end
  
  test "performing an unprotected action should result in challenge cookie being set" do
    assert_nil @request.cookies[@cookie_name]
    get :show
    assert @request.cookies[@cookie_name]
  end
  
  test "performing a protected action without the challenge cookie being set should return bad request" do
    post :protected_action, :id => 1
    assert_response :bad_request
  end
  
  test "performing protected action with challenge cookie set should succeed" do
    set_challenge_cookie
    post :protected_action, :id => 1
    assert_response :success
  end
  
  test "successful completion of protected action should set cookie noting completion" do
    assert_nil @request.cookies['/tests/protected_action/1']
    set_challenge_cookie
    post :protected_action, :id => 1
    assert @request.cookies['/tests/protected_action/1']
  end
  
  test "attempting to perform protected action more than once should return bad request" do
    set_challenge_cookie
    post :protected_action, :id => 1
    assert_response :success
    post :protected_action, :id => 1
    assert_response :bad_request
  end
  
  test "attempting to perform protected action more than once with different ids should return success" do
    set_challenge_cookie
    post :protected_action, :id => 1
    assert_response :success
    post :protected_action, :id => 2
    assert_response :success
  end
  
  private
  
    def set_challenge_cookie
      @request.cookies[@cookie_name] = "#{@cookie_name}=true; path="
    end
  
end