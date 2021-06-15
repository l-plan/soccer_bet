require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  setup do
    @game = games(:one)
  end

  test "visiting the index" do
    visit games_url
    assert_selector "h1", text: "Games"
  end

  test "creating a Game" do
    visit games_url
    click_on "New Game"

    fill_in "Away", with: @game.away_id
    fill_in "Date", with: @game.date
    fill_in "Home", with: @game.home_id
    fill_in "Nr", with: @game.nr
    fill_in "Score away", with: @game.score_away
    fill_in "Score home", with: @game.score_home
    click_on "Create Game"

    assert_text "Game was successfully created"
    click_on "Back"
  end

  test "updating a Game" do
    visit games_url
    click_on "Edit", match: :first

    fill_in "Away", with: @game.away_id
    fill_in "Date", with: @game.date
    fill_in "Home", with: @game.home_id
    fill_in "Nr", with: @game.nr
    fill_in "Score away", with: @game.score_away
    fill_in "Score home", with: @game.score_home
    click_on "Update Game"

    assert_text "Game was successfully updated"
    click_on "Back"
  end

  test "destroying a Game" do
    visit games_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Game was successfully destroyed"
  end
end
