require "test_helper"

class Bet::GamesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bet_game = bet_games(:one)
  end

  test "should get index" do
    get bet_games_url
    assert_response :success
  end

  test "should get new" do
    get new_bet_game_url
    assert_response :success
  end

  test "should create bet_game" do
    assert_difference('Bet::Game.count') do
      post bet_games_url, params: { bet_game: { away: @bet_game.away, game_id: @bet_game.game_id, home: @bet_game.home } }
    end

    assert_redirected_to bet_game_url(Bet::Game.last)
  end

  test "should show bet_game" do
    get bet_game_url(@bet_game)
    assert_response :success
  end

  test "should get edit" do
    get edit_bet_game_url(@bet_game)
    assert_response :success
  end

  test "should update bet_game" do
    patch bet_game_url(@bet_game), params: { bet_game: { away: @bet_game.away, game_id: @bet_game.game_id, home: @bet_game.home } }
    assert_redirected_to bet_game_url(@bet_game)
  end

  test "should destroy bet_game" do
    assert_difference('Bet::Game.count', -1) do
      delete bet_game_url(@bet_game)
    end

    assert_redirected_to bet_games_url
  end
end
