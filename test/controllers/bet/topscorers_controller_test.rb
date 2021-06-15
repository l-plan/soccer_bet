require "test_helper"

class Bet::TopscorersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bet_topscorer = bet_topscorers(:one)
  end

  test "should get index" do
    get bet_topscorers_url
    assert_response :success
  end

  test "should get new" do
    get new_bet_topscorer_url
    assert_response :success
  end

  test "should create bet_topscorer" do
    assert_difference('Bet::Topscorer.count') do
      post bet_topscorers_url, params: { bet_topscorer: { participant_id: @bet_topscorer.participant_id, player_id: @bet_topscorer.player_id } }
    end

    assert_redirected_to bet_topscorer_url(Bet::Topscorer.last)
  end

  test "should show bet_topscorer" do
    get bet_topscorer_url(@bet_topscorer)
    assert_response :success
  end

  test "should get edit" do
    get edit_bet_topscorer_url(@bet_topscorer)
    assert_response :success
  end

  test "should update bet_topscorer" do
    patch bet_topscorer_url(@bet_topscorer), params: { bet_topscorer: { participant_id: @bet_topscorer.participant_id, player_id: @bet_topscorer.player_id } }
    assert_redirected_to bet_topscorer_url(@bet_topscorer)
  end

  test "should destroy bet_topscorer" do
    assert_difference('Bet::Topscorer.count', -1) do
      delete bet_topscorer_url(@bet_topscorer)
    end

    assert_redirected_to bet_topscorers_url
  end
end
