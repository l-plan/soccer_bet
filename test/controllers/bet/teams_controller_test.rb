require "test_helper"

class Bet::TeamsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bet_team = bet_teams(:one)
  end

  test "should get index" do
    get bet_teams_url
    assert_response :success
  end

  test "should get new" do
    get new_bet_team_url
    assert_response :success
  end

  test "should create bet_team" do
    assert_difference('Bet::Team.count') do
      post bet_teams_url, params: { bet_team: { participant_id: @bet_team.participant_id, stage: @bet_team.stage, team_id: @bet_team.team_id } }
    end

    assert_redirected_to bet_team_url(Bet::Team.last)
  end

  test "should show bet_team" do
    get bet_team_url(@bet_team)
    assert_response :success
  end

  test "should get edit" do
    get edit_bet_team_url(@bet_team)
    assert_response :success
  end

  test "should update bet_team" do
    patch bet_team_url(@bet_team), params: { bet_team: { participant_id: @bet_team.participant_id, stage: @bet_team.stage, team_id: @bet_team.team_id } }
    assert_redirected_to bet_team_url(@bet_team)
  end

  test "should destroy bet_team" do
    assert_difference('Bet::Team.count', -1) do
      delete bet_team_url(@bet_team)
    end

    assert_redirected_to bet_teams_url
  end
end
