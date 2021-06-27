require "application_system_test_case"

class Bet::PlayersTest < ApplicationSystemTestCase
  setup do
    @bet_player = bet_players(:one)
  end

  test "visiting the index" do
    visit bet_players_url
    assert_selector "h1", text: "Bet/Players"
  end

  test "creating a Player" do
    visit bet_players_url
    click_on "New Bet/Player"

    fill_in "Participant", with: @bet_player.participant_id
    fill_in "Player", with: @bet_player.player_id
    fill_in "Score", with: @bet_player.score
    fill_in "Stage", with: @bet_player.stage
    click_on "Create Player"

    assert_text "Player was successfully created"
    click_on "Back"
  end

  test "updating a Player" do
    visit bet_players_url
    click_on "Edit", match: :first

    fill_in "Participant", with: @bet_player.participant_id
    fill_in "Player", with: @bet_player.player_id
    fill_in "Score", with: @bet_player.score
    fill_in "Stage", with: @bet_player.stage
    click_on "Update Player"

    assert_text "Player was successfully updated"
    click_on "Back"
  end

  test "destroying a Player" do
    visit bet_players_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Player was successfully destroyed"
  end
end
