require "application_system_test_case"

class Bet::TopplayersTest < ApplicationSystemTestCase
  setup do
    @bet_topplayer = bet_topplayers(:one)
  end

  test "visiting the index" do
    visit bet_topplayers_url
    assert_selector "h1", text: "Bet/Topplayers"
  end

  test "creating a Topplayer" do
    visit bet_topplayers_url
    click_on "New Bet/Topplayer"

    fill_in "Participant", with: @bet_topplayer.participant_id
    fill_in "Player", with: @bet_topplayer.player_id
    click_on "Create Topplayer"

    assert_text "Topplayer was successfully created"
    click_on "Back"
  end

  test "updating a Topplayer" do
    visit bet_topplayers_url
    click_on "Edit", match: :first

    fill_in "Participant", with: @bet_topplayer.participant_id
    fill_in "Player", with: @bet_topplayer.player_id
    click_on "Update Topplayer"

    assert_text "Topplayer was successfully updated"
    click_on "Back"
  end

  test "destroying a Topplayer" do
    visit bet_topplayers_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Topplayer was successfully destroyed"
  end
end
