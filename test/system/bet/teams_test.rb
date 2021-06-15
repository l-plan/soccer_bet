require "application_system_test_case"

class Bet::TeamsTest < ApplicationSystemTestCase
  setup do
    @bet_team = bet_teams(:one)
  end

  test "visiting the index" do
    visit bet_teams_url
    assert_selector "h1", text: "Bet/Teams"
  end

  test "creating a Team" do
    visit bet_teams_url
    click_on "New Bet/Team"

    fill_in "Participant", with: @bet_team.participant_id
    fill_in "Stage", with: @bet_team.stage
    fill_in "Team", with: @bet_team.team_id
    click_on "Create Team"

    assert_text "Team was successfully created"
    click_on "Back"
  end

  test "updating a Team" do
    visit bet_teams_url
    click_on "Edit", match: :first

    fill_in "Participant", with: @bet_team.participant_id
    fill_in "Stage", with: @bet_team.stage
    fill_in "Team", with: @bet_team.team_id
    click_on "Update Team"

    assert_text "Team was successfully updated"
    click_on "Back"
  end

  test "destroying a Team" do
    visit bet_teams_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Team was successfully destroyed"
  end
end
