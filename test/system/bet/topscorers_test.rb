require "application_system_test_case"

class Bet::TopscorersTest < ApplicationSystemTestCase
  setup do
    @bet_topscorer = bet_topscorers(:one)
  end

  test "visiting the index" do
    visit bet_topscorers_url
    assert_selector "h1", text: "Bet/Topscorers"
  end

  test "creating a Topscorer" do
    visit bet_topscorers_url
    click_on "New Bet/Topscorer"

    fill_in "Participant", with: @bet_topscorer.participant_id
    fill_in "Player", with: @bet_topscorer.player_id
    click_on "Create Topscorer"

    assert_text "Topscorer was successfully created"
    click_on "Back"
  end

  test "updating a Topscorer" do
    visit bet_topscorers_url
    click_on "Edit", match: :first

    fill_in "Participant", with: @bet_topscorer.participant_id
    fill_in "Player", with: @bet_topscorer.player_id
    click_on "Update Topscorer"

    assert_text "Topscorer was successfully updated"
    click_on "Back"
  end

  test "destroying a Topscorer" do
    visit bet_topscorers_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Topscorer was successfully destroyed"
  end
end
