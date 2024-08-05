require "test_helper"

class PuzzlesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get puzzles_index_url
    assert_response :success
  end

  test "should get check_answer" do
    get puzzles_check_answer_url
    assert_response :success
  end
end
