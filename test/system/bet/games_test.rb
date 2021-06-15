require "application_system_test_case"

class Bet::GamesTest < ApplicationSystemTestCase
  setup do
    @bet_game = bet_games(:one)
  end

  test "visiting the index" do
    visit bet_games_url
    assert_selector "h1", text: "Bet/Games"
  end

  test "creating a Game" do
    visit bet_games_url
    click_on "New Bet/Game"

    fill_in "Away", with: @bet_game.away
    fill_in "Game", with: @bet_game.game_id
    fill_in "Home", with: @bet_game.home
    click_on "Create Game"

    assert_text "Game was successfully created"
    click_on "Back"
  end

  test "updating a Game" do
    visit bet_games_url
    click_on "Edit", match: :first

    fill_in "Away", with: @bet_game.away
    fill_in "Game", with: @bet_game.game_id
    fill_in "Home", with: @bet_game.home
    click_on "Update Game"

    assert_text "Game was successfully updated"
    click_on "Back"
  end

  test "destroying a Game" do
    visit bet_games_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Game was successfully destroyed"
  end
end
