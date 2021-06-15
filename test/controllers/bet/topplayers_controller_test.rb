require "test_helper"

class Bet::TopplayersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bet_topplayer = bet_topplayers(:one)
  end

  test "should get index" do
    get bet_topplayers_url
    assert_response :success
  end

  test "should get new" do
    get new_bet_topplayer_url
    assert_response :success
  end

  test "should create bet_topplayer" do
    assert_difference('Bet::Topplayer.count') do
      post bet_topplayers_url, params: { bet_topplayer: { participant_id: @bet_topplayer.participant_id, player_id: @bet_topplayer.player_id } }
    end

    assert_redirected_to bet_topplayer_url(Bet::Topplayer.last)
  end

  test "should show bet_topplayer" do
    get bet_topplayer_url(@bet_topplayer)
    assert_response :success
  end

  test "should get edit" do
    get edit_bet_topplayer_url(@bet_topplayer)
    assert_response :success
  end

  test "should update bet_topplayer" do
    patch bet_topplayer_url(@bet_topplayer), params: { bet_topplayer: { participant_id: @bet_topplayer.participant_id, player_id: @bet_topplayer.player_id } }
    assert_redirected_to bet_topplayer_url(@bet_topplayer)
  end

  test "should destroy bet_topplayer" do
    assert_difference('Bet::Topplayer.count', -1) do
      delete bet_topplayer_url(@bet_topplayer)
    end

    assert_redirected_to bet_topplayers_url
  end
end
