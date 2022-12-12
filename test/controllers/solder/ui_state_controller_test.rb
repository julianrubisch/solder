require "test_helper"

module Solder
  class UiStateControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    test "should get update" do
      get ui_state_update_url
      assert_response :success
    end

    test "should get show" do
      get ui_state_show_url
      assert_response :success
    end
  end
end
