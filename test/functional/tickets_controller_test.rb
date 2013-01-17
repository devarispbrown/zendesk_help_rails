require_relative '../test_helper'

class TicketsControllerTest < ActionController::TestCase
  tests TicketsController

  def login
    @stub[:user] = User.first
  end

  setup do
    @stub = {}
    def @stub.authenticate(x); self[:user]; end
    request.env['warden'] = @stub
  end

  describe "#index" do
    it "renders" do
      login
      get :index
      assert_response :success
    end
  end

  describe "#show" do
    it "renders" do
      get :show, :id => 1
      assert_response :success
      assert assigns :comments
    end
  end

  describe "#new" do
    it "renders" do
      get :new
      assert_response :success
    end

    describe "logged in" do
      setup{ login }

      it "renders and assigns" do
        get :new
        assert_response :success
        refute assigns :profile
        assert_equal [], assigns(:game)
      end

      it "renders and assigns with a logged in user with a profile" do
        profile = Profile.create!(:email => @stub[:user].email)
        get :new
        assert_response :success
        assert_equal profile, assigns(:profile)
        assert_equal [], assigns(:game)
      end
    end
  end

  describe "#create" do
    it "creates a ticket" do
      post :create, :email => User.first.email, :subject => "asdfadfadf", :body => "afadfadfa", :full_name => "asdfadf adfadfda"
      assert_response :success
      assert assigns(:ticket).id
    end
  end

  describe "#update" do
    it "adds a comment to a ticket" do
      assert_difference "FooClient.instance.requests.find(:id => 1).comments.count", 1 do
        put :update, :id => 1, :comment => "sdlfadfaf"
        assert_redirected_to "/tickets/1"
      end
    end
  end





  # test "should get tickets" do
  #   

  #   get :index
  #   assert_response :success
  # end
end
