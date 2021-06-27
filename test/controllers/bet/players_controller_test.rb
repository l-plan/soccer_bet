require "test_helper"

class Bet::PlayersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bet_player = bet_players(:one)
  end

  test "should get index" do
    get bet_players_url
    assert_response :success
  end

  test "should get new" do
    get new_bet_player_url
    assert_response :success
  end

  test "should create bet_player" do
    assert_difference('Bet::Player.count') do
      post bet_players_url, params: { bet_player: { participant_id: @bet_player.participant_id, player_id: @bet_player.player_id, score: @bet_player.score, stage: @bet_player.stage } }
    end

    assert_redirected_to bet_player_url(Bet::Player.last)
  end

  test "should show bet_player" do
    get bet_player_url(@bet_player)
    assert_response :success
  end

  test "should get edit" do
    get edit_bet_player_url(@bet_player)
    assert_response :success
  end

  test "should update bet_player" do
    patch bet_player_url(@bet_player), params: { bet_player: { participant_id: @bet_player.participant_id, player_id: @bet_player.player_id, score: @bet_player.score, stage: @bet_player.stage } }
    assert_redirected_to bet_player_url(@bet_player)
  end

  test "should destroy bet_player" do
    assert_difference('Bet::Player.count', -1) do
      delete bet_player_url(@bet_player)
    end

    assert_redirected_to bet_players_url
  end
end
