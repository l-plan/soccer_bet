require "application_system_test_case"

class Fifa::FairPlayRankingsTest < ApplicationSystemTestCase
  setup do
    @fifa_fair_play_ranking = fifa_fair_play_rankings(:one)
  end

  test "visiting the index" do
    visit fifa_fair_play_rankings_url
    assert_selector "h1", text: "Fair play rankings"
  end

  test "should create fair play ranking" do
    visit fifa_fair_play_rankings_url
    click_on "New fair play ranking"

    fill_in "Points", with: @fifa_fair_play_ranking.points
    fill_in "Team", with: @fifa_fair_play_ranking.team_id
    click_on "Create Fair play ranking"

    assert_text "Fair play ranking was successfully created"
    click_on "Back"
  end

  test "should update Fair play ranking" do
    visit fifa_fair_play_ranking_url(@fifa_fair_play_ranking)
    click_on "Edit this fair play ranking", match: :first

    fill_in "Points", with: @fifa_fair_play_ranking.points
    fill_in "Team", with: @fifa_fair_play_ranking.team_id
    click_on "Update Fair play ranking"

    assert_text "Fair play ranking was successfully updated"
    click_on "Back"
  end

  test "should destroy Fair play ranking" do
    visit fifa_fair_play_ranking_url(@fifa_fair_play_ranking)
    click_on "Destroy this fair play ranking", match: :first

    assert_text "Fair play ranking was successfully destroyed"
  end
end
